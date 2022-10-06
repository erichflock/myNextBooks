//
//  Book+Fixture.swift
//  MyNextBooksTests
//
//  Created by Erich Flock on 28.09.22.
//

@testable import MyNextBooks

extension Book {
    
    static func fixture(title: String = "title",
                        authors: String = "authors",
                        imageUrl: String? = "http://imageurl.com",
                        publishedDate: String? = nil,
                        description: String? = nil) -> Self {
        .init(title: title, authors: authors, imageUrl: imageUrl, publishedDate: publishedDate, description: description)
    }
    
}
