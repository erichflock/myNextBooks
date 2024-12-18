//
//  Book+Fixture.swift
//  MyNextBooksTests
//
//  Created by Erich Flock on 28.09.22.
//

@testable import MyNextBooks
import Foundation

extension Book {
    
    static func fixture(id: String = UUID().uuidString,
                        title: String = "title",
                        authors: String = "authors",
                        imageUrl: String? = "http://imageurl.com",
                        publishedDate: String? = nil,
                        description: String? = nil,
                        pageCount: Int? = nil,
                        language: String? = nil,
                        publisher: String? = nil,
                        price: String? = nil) -> Self {
        .init(
            id: id,
            title: title,
            authors: authors,
            imageUrl: imageUrl,
            publishedDate: publishedDate,
            description: description,
            pageCount: pageCount,
            language: language,
            publisher: publisher,
            price: price
        )
    }
    
}
