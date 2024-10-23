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
    
    func test_getBooks_whenExecuted_shouldReturnExpectedBooks() async {
        let expectedBooks: [Book] = [.fixture(id: "firstBookID", title: "Harry Potter", authors: "J.K Rowling", imageUrl: "harrypotter.com", publishedDate: "01-02-2000", description: "This is a book about a young boy that discovers super powers."),
                                     .fixture(id: "secondBookID", title: "The Lord of the Rings", authors: "J.R.R. Tolkien, Tolkien", imageUrl: "lordoftherings.com")]
        booksApiSpy.bookApiModel = .fixture(items: [.fixture(id: "firstBookID", volumeInfo: .fixture(title: "Harry Potter", authors: ["J.K Rowling"], publishedDate: "01-02-2000", description: "This is a book about a young boy that discovers super powers.", imageLinks: .fixture(thumbnail: "harrypotter.com"))),
                                                    .fixture(id: "secondBookID", volumeInfo: .fixture(title: "The Lord of the Rings", authors: ["J.R.R. Tolkien", "Tolkien"], imageLinks: .fixture(thumbnail: "lordoftherings.com")))])
        
        let returnedBooks = await sut.getBooks(with: "any terms")
        
        XCTAssertEqual(returnedBooks.count, 2)
        XCTAssertEqual(returnedBooks.first?.id, expectedBooks.first?.id)
        XCTAssertEqual(returnedBooks.first?.title, expectedBooks.first?.title)
        XCTAssertEqual(returnedBooks.first?.authors, expectedBooks.first?.authors)
        XCTAssertEqual(returnedBooks.first?.publishedDate, expectedBooks.first?.publishedDate)
        XCTAssertEqual(returnedBooks.first?.description, expectedBooks.first?.description)
        XCTAssertEqual(returnedBooks.first?.imageUrl, expectedBooks.first?.imageUrl)
        XCTAssertEqual(returnedBooks.last?.id, expectedBooks.last?.id)
        XCTAssertEqual(returnedBooks.last?.title, expectedBooks.last?.title)
        XCTAssertEqual(returnedBooks.last?.authors, expectedBooks.last?.authors)
        XCTAssertEqual(returnedBooks.last?.imageUrl, expectedBooks.last?.imageUrl)
        XCTAssertEqual(returnedBooks.last?.publishedDate, expectedBooks.last?.publishedDate)
        XCTAssertEqual(returnedBooks.last?.description, expectedBooks.last?.description)
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
