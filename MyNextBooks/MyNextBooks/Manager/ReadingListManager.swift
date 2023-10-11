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
    
    @Published var readingList: [Book] = [] {
        didSet {
            saveReadingList()
        }
    }
    
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
        readingList.remove(atOffsets: offsets)
    }
    
    private func loadSavedReadingList() {
        do {
            if let data = UserDefaults.standard.data(forKey: readingListKey) {
                let savedReadingList = try JSONDecoder().decode([Book].self, from: data)
                readingList = savedReadingList
            }
        } catch let error {
            print("Error decoding: \(error)")
        }
    }
    
    private func saveReadingList() {
        do {
            let data = try JSONEncoder().encode(readingList)
            UserDefaults.standard.set(data, forKey: readingListKey)
        } catch let error {
            print("Error encoding: \(error)")
        }
    }
    
    private func storeInCloud(book: Book) {
        let bookRecord = CKRecord(recordType: "Book", recordID: .init(recordName: book.id))
        bookRecord["title"] = book.title as CKRecordValue
        bookRecord["authors"] = book.authors as CKRecordValue
        bookRecord["imageUrl"] = book.imageUrl as? CKRecordValue
        bookRecord["publishedDate"] = book.publishedDate as? CKRecordValue
        bookRecord["description"] = book.description as? CKRecordValue
        
        CKContainer(identifier: "iCloud.MyNextBooks").privateCloudDatabase.save(bookRecord) { record, error in
            if let error {
                print("book not saved in the cloud. Error: \(error.localizedDescription)")
            } else {
                print("book saved in the cloud")
            }
        }
    }
    
    private func removeFromCloud(book: Book) {
        CKContainer(identifier: "iCloud.MyNextBooks").privateCloudDatabase.delete(withRecordID: .init(recordName: book.id)) { recordID, error  in
            if let error {
                print("could not deleted record: \(String(describing: recordID)). Error: \(error.localizedDescription)")
            } else {
                print("record: \(String(describing: recordID)) deleted")
            }
        }
    }
    
}
