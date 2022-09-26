//
//  BooksManager.swift
//  MyNextBooks
//
//  Created by Erich Flock on 26.09.22.
//

class BooksManager {
    
    var booksApi: BooksApiProtocol = BooksApi()
    
    func getBooks() -> [Book] {
        return []
    }
    
    private func map(bookApiModelItem: BookApiModel.Item) -> Book? {
        return nil
    }
    
}
