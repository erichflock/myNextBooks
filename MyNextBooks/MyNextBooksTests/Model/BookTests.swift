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
    
    func test_getFormattedPublishedDate_whenDate20150201_shouldReturn01022015() {
        let book: Book = .fixture(publishedDate: "2015-02-01")
        
        let formattedDate = book.getFormattedPublishedDate()
        
        XCTAssertEqual(formattedDate, "01/02/2015")
    }
    
    func test_getFormattedPublishedDate_whenDate20200102_shouldReturn02012020() {
        let book: Book = .fixture(publishedDate: "2020-01-02")
        
        let formattedDate = book.getFormattedPublishedDate()
        
        XCTAssertEqual(formattedDate, "02/01/2020")
    }
    
}
