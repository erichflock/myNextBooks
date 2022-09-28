//
//  BooksManager.swift
//  MyNextBooks
//
//  Created by Erich Flock on 26.09.22.
//

class BooksManager {
    
    var booksApi: BooksApiProtocol = BooksApi()
    
    func getBooks(with terms: String) async -> [Book] {
        var books: [Book] = []
        do {
            let apibooks = try await booksApi.getBooks(with: terms)
            apibooks?.items?.forEach({ item in
                if let book = map(bookApiModelItem: item) {
                    books.append(book)
                }
            })
        } catch {
            
        }
        return books
    }
    
    private func map(bookApiModelItem: BookApiModel.Item) -> Book? {
        guard let title = bookApiModelItem.volumeInfo?.title,
              let authors = bookApiModelItem.volumeInfo?.authors?.joined(separator: ", "),
              let imageURL = bookApiModelItem.volumeInfo?.imageLinks?.smallThumbnail else {
            return nil
        }
        return .init(title: title, authors: authors, imageUrl: imageURL)
    }
    
}
