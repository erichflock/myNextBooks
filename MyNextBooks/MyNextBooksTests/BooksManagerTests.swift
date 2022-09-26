//
//  BooksManagerTests.swift
//  MyNextBooksTests
//
//  Created by Erich Flock on 26.09.22.
//

import XCTest
@testable import MyNextBooks

class BooksManagerTests: XCTestCase {

    private var sut: BooksManager!
    private var booksApiSpy = BooksApiSpy()
    
    override func setUpWithError() throws {
        sut = BooksManager()
        sut.booksApi = booksApiSpy
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_getBooks_whenExecuted_shouldCallGetBooksOnApiWithTheSameTerms() async {
        let expectedTerms = "flowers"
        XCTAssertNil(booksApiSpy.terms, "precondition")
        XCTAssertEqual(booksApiSpy.getBooksCallCount, 0, "precondition")
        
        await sut.getBooks(with: expectedTerms)
        
        XCTAssertEqual(booksApiSpy.getBooksCallCount, 1)
        XCTAssertEqual(booksApiSpy.terms, expectedTerms)
    }
    
}

private class BooksApiSpy: BooksApiProtocol {
    
    private(set) var getBooksCallCount = 0
    private(set) var terms: String?
    var bookApiModel: BookApiModel?
    
    func getBooks(with terms: String) async throws -> BookApiModel? {
        getBooksCallCount += 1
        self.terms = terms
        return bookApiModel
    }
    
}
