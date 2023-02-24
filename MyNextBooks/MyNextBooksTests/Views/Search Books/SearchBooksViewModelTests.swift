//
//  SearchBooksViewModelTests.swift
//  MyNextBooksTests
//
//  Created by Erich Flock on 24.02.23.
//

import XCTest
@testable import MyNextBooks

final class SearchBooksViewModelTests: XCTestCase {
    
    private var sut: SearchBooksViewModel!
    
    override func setUpWithError() throws {
        sut = SearchBooksViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_searchBooks_whenBooksFound_shouldUpdateBooks() async {
        let booksManager = BooksManagerFake()
        booksManager.books = [.fixture(id: "123"),
                              .fixture(id: "321")]
        sut.booksManager = booksManager
        XCTAssertTrue(sut.books.isEmpty, "precondition")
        
        await sut.searchBooks()
        
        XCTAssertEqual(sut.books.count, 2)
        XCTAssertEqual(sut.books[0].id, "123")
        XCTAssertEqual(sut.books[1].id, "321")
    }
    
    func test_removeBooks_whenExecuted_shouldRemoveAllBooks() async {
        await addBooks()
        XCTAssertFalse(sut.books.isEmpty, "precondition")
        
        sut.removeBooks()
        
        XCTAssertTrue(sut.books.isEmpty)
    }
    
}

//MARK: Helpers
extension SearchBooksViewModelTests {
    
    private func addBooks() async {
        let booksManager = BooksManagerFake()
        booksManager.books = [.fixture(id: "123"),
                              .fixture(id: "321")]
        sut.booksManager = booksManager
        await sut.searchBooks()
    }
    
}

private class BooksManagerFake: BooksManager {
    
    var books: [Book] = []
    
    override func getBooks(with terms: String) async -> [Book] {
        return books
    }
    
}
