//
//  ReadingListManagerTests.swift
//  MyNextBooksTests
//
//  Created by Erich Flock on 07.10.22.
//

import XCTest
@testable import MyNextBooks

class ReadingListManagerTests: XCTestCase {
    
    private var sut: ReadingListManagerProtocol!
    
    override func setUpWithError() throws {
        sut = ReadingListManagerSpy()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_addBook_whenBookAdded_shouldAddBookToReadlingList() {
        let book: Book = .fixture()
        XCTAssertFalse(sut.readingList.contains(book), "precondition")
        
        sut.add(book: book)
        
        XCTAssertTrue(sut.readingList.contains(book))
    }
    
    func test_addBook_whenBookAlreadyAdded_shouldNotAddBookToReadlingList() {
        let book: Book = .fixture()
        sut.readingList.append(book)
        XCTAssertEqual(sut.readingList.filter({ $0 == book }).count, 1, "precondition")
        
        sut.add(book: book)
        
        XCTAssertEqual(sut.readingList.filter({ $0 == book }).count, 1)
    }
    
    func test_removeBook_whenBookRemoved_shouldRemoveBookFromReadlingList() {
        let book: Book = .fixture()
        sut.readingList.append(book)
        XCTAssertTrue(sut.readingList.contains(book), "precondition")
        
        sut.remove(book: book)
        
        XCTAssertFalse(sut.readingList.contains(book))
    }
    
}

//Same code used on production code - Strategy to test singleton
private class ReadingListManagerSpy: ReadingListManagerProtocol {
    
    var readingList: [Book] = []
    
    func add(book: Book) {
        guard !readingList.contains(book) else { return }
        readingList.append(book)
    }
    
    func remove(book: Book) {
        if let index = readingList.firstIndex(where: { $0 == book }) {
            readingList.remove(at: index)
        }
    }
    
}
