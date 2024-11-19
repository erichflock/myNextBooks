//
//  ReadingListManager.swift
//  MyNextBooks
//
//  Created by Erich Flock on 07.10.22.
//

import SwiftUI
import CloudKit

protocol ReadingListManagerProtocol {
    var readingList: [Book] { get set }
    func add(book: Book)
    func remove(book: Book)
}

class ReadingListManager: ObservableObject, ReadingListManagerProtocol {
    
    private init() {
        loadSavedReadingList()
    }
    
    static var shared = ReadingListManager()
    private let defaults = UserDefaults.standard
    private let readingListKey = "savedReadingList"
    private let ckcontainer = CKContainer(identifier: "iCloud.MyNextBooks").privateCloudDatabase
    
    @Published var readingList: [Book] = []
    
    func add(book: Book) {
        guard !readingList.contains(book) else { return }
        readingList.append(book)
        storeInCloud(book: book)
    }
    
    func remove(book: Book) {
        if let index = readingList.firstIndex(where: { $0 == book }) {
            readingList.remove(at: index)
        }
        removeFromCloud(book: book)
    }
    
    //Used on list delete action
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let book = readingList.remove(at: index)
            removeFromCloud(book: book)
        }
    }
    
    private func loadSavedReadingList() {
        fetchAllRecordsFromCloud()
    }
    
    private func storeInCloud(book: Book) {
        let bookRecord = CKRecord(recordType: Book.CKRecordType.value, recordID: .init(recordName: book.id))
        bookRecord[Book.CKKeys.title] = book.title as CKRecordValue
        bookRecord[Book.CKKeys.authors] = book.authors as CKRecordValue
        bookRecord[Book.CKKeys.imageUrl] = book.imageUrl as? CKRecordValue
        bookRecord[Book.CKKeys.publishedDate] = book.publishedDate as? CKRecordValue
        bookRecord[Book.CKKeys.description] = book.description as? CKRecordValue
        
        ckcontainer.save(bookRecord) { record, error in
            if let error {
                print("book not saved in the cloud. Error: \(error.localizedDescription)")
            } else {
                print("book saved in the cloud")
            }
        }
    }
    
    private func removeFromCloud(book: Book) {
        ckcontainer.delete(withRecordID: .init(recordName: book.id)) { recordID, error  in
            if let error {
                print("could not deleted record: \(String(describing: recordID)). Error: \(error.localizedDescription)")
            } else {
                print("record: \(String(describing: recordID)) deleted")
            }
        }
    }
    
    private func fetchAllRecordsFromCloud() {
        ckcontainer.fetch(withQuery: .init(recordType: Book.CKRecordType.value, predicate: .init(value: true))) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                Task { @MainActor in
                    self.readingList = self.mapRecords(success.matchResults)
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func mapRecords(_ matchResults: [(CKRecord.ID, Result<CKRecord, Error>)]) -> [Book] {
        var books: [Book] = []
        for result in matchResults {
            switch result.1 {
            case .success(let record):
                if let book = map(record: record) {
                    books.append(book)
                }
            case .failure(_): break
            }
        }
        return books
    }
    
    private func map(record: CKRecord) -> Book? {
        guard let title = record[Book.CKKeys.title] as? String,
              let authors = record[Book.CKKeys.authors] as? String else { return nil }
        
        return .init(id: record.recordID.recordName,
                     title: title,
                     authors: authors,
                     imageUrl: record[Book.CKKeys.imageUrl] as? String,
                     publishedDate: record[Book.CKKeys.publishedDate] as? String,
                     description: record[Book.CKKeys.description] as? String
        )
    }
    
}
