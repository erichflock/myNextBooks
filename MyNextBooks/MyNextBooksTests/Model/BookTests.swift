//
//  BookTests.swift
//  MyNextBooksTests
//
//  Created by Erich Flock on 28.09.22.
//

import XCTest
@testable import MyNextBooks

class BookTests: XCTestCase {
    
    func test_getSecureImageUrl_whenImageUrlWithHttp_shouldReturnImageUrlWithHttps() {
        let book: Book = .fixture(imageUrl: "http://imageurl.com")
        
        let secureImageUrl = book.getSecureImageUrl()
        
        XCTAssertEqual("https://imageurl.com", secureImageUrl)
    }
    
    func test_getSecureImageUrl_whenImageUrlWithHttps_shouldReturnImageUrlWithoutChanges() {
        let book: Book = .fixture(imageUrl: "https://imageurl.com")
        
        let secureImageUrl = book.getSecureImageUrl()
        
        XCTAssertEqual(book.imageUrl, secureImageUrl)
    }
    
    func test_getSecureImageUrl_whenNoImageUrl_shouldReturnNil() {
        let book: Book = .fixture(imageUrl: nil)
        
        let secureImageUrl = book.getSecureImageUrl()
        
        XCTAssertNil(secureImageUrl)
    }
    
}
