//
//  ReadingListManager.swift
//  MyNextBooks
//
//  Created by Erich Flock on 07.10.22.
//

import SwiftUI

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
    }
    
    func remove(book: Book) {
        if let index = readingList.firstIndex(where: { $0 == book }) {
            readingList.remove(at: index)
        }
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
    
}
