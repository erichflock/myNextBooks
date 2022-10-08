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
        guard let id = bookApiModelItem.id,
              let title = bookApiModelItem.volumeInfo?.title,
              let authors = bookApiModelItem.volumeInfo?.authors?.joined(separator: ", ")
        else {
            return nil
        }
        let publishedDate = bookApiModelItem.volumeInfo?.publishedDate
        let description = bookApiModelItem.volumeInfo?.description
        let imageURL = bookApiModelItem.volumeInfo?.imageLinks?.smallThumbnail
        return .init(id: id, title: title, authors: authors, imageUrl: imageURL, publishedDate: publishedDate, description: description)
    }
    
}
