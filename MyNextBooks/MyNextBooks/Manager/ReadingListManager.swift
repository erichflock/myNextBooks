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
    
    private init() {}
    static var shared = ReadingListManager()
    
    @Published var readingList: [Book] = []
    
    func add(book: Book) {
        guard !readingList.contains(book) else { return }
        readingList.append(book)
    }
    
    func remove(book: Book) {
        if let index = readingList.firstIndex(where: { $0 == book }) {
            readingList.remove(at: index)
        }
    }
    
}
