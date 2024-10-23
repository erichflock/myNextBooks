//
//  MyNextBooksUITests.swift
//  MyNextBooksUITests
//
//  Created by Erich Flock on 10.10.22.
//

import XCTest

class MyNextBooksUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("UITestMode")
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
        //Springboard.deleteApp()
    }
    
    func test_addBookToReadingList() {
        app.tapOnTabBarItem("Reading List")
        
        XCTAssertTrue(app.isVisible("readingList_emptyStateView"))
        
        app.tapOnTabBarItem("Search")
        
        app.search("the ministry for the future")
        
        app.tapOn(text: "The Ministry for the Future")
        
        app.tapOnButton("bookDetails_heartButton")
        
        app.tapOnTabBarItem("Reading List")
        
        app.tapOn(text: "The Ministry for the Future")
    }
    
    func test_removeBookFromReadingList() {
        app.tapOnTabBarItem("Reading List")
        
        XCTAssertTrue(app.isVisible("readingList_emptyStateView"))
        
        app.tapOnTabBarItem("Search")
        
        app.search("the ministry for the future")
        
        app.tapOn(text: "The Ministry for the Future")
        
        app.tapOnButton("bookDetails_heartButton")
        
        app.tapOnTabBarItem("Reading List")
        
        app.tapOn(text: "The Ministry for the Future")
        
        app.tapOnButton("bookDetails_heartButton")
        
        app.tapOnTextOnNavigationBar("Reading List")
        
        XCTAssertTrue(app.isVisible("readingList_emptyStateView"))
    }
    
}
