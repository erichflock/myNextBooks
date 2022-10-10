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
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
        Springboard.deleteApp()
    }
    
    func test_addBookToReadingList() {
        app.tapOnTabBarItem("tabBar_readingList")
        
        XCTAssertTrue(app.isVisible("readingList_emptyStateView"))
        
        app.tapOnTabBarItem("tabBar_searchBooks")
        
        app.search("the ministry for the future")
        
        app.tapOn(text: "The Ministry for the Future")
        
        app.tapOnButton("bookDetails_heartButton")
        
        app.tapOnTabBarItem("tabBar_readingList")
        
        app.tapOn(text: "The Ministry for the Future")
    }
    
    func test_removeBookFromReadingList() {
        app.tapOnTabBarItem("tabBar_readingList")
        
        XCTAssertTrue(app.isVisible("readingList_emptyStateView"))
        
        app.tapOnTabBarItem("tabBar_searchBooks")
        
        app.search("the ministry for the future")
        
        app.tapOn(text: "The Ministry for the Future")
        
        app.tapOnButton("bookDetails_heartButton")
        
        app.tapOnTabBarItem("tabBar_readingList")
        
        app.tapOn(text: "The Ministry for the Future")
        
        app.tapOnButton("bookDetails_heartButton")
        
        app.tapOnTextOnNavigationBar("Reading List")
        
        XCTAssertTrue(app.isVisible("readingList_emptyStateView"))
    }
    
}

extension XCUIApplication {
    
    func tapOnButton(_ identifier: String, timeout: Double = 10) {
        let button = buttons[identifier].firstMatch
        if button.waitForExistence(timeout: timeout) {
            button.tap()
        } else {
            XCTFail("Fail to tap on button \(identifier)")
        }
    }
    
    func tapOnElement(_ identfier: String) {
        let element = otherElements[identfier].firstMatch
        if element.waitForExistence(timeout: 10) {
            element.tap()
        } else {
            XCTFail("Fail to tap on element \(identfier)")
        }
    }
    
    func tapOnTabBarItem(_ identfier: String) {
        let element = tabBars.buttons[identfier]
        if element.waitForExistence(timeout: 10) {
            element.tap()
        } else {
            XCTFail("Fail to tap on tap bar item \(identfier)")
        }
    }
        
    func tapOn(text: String) {
        let element = staticTexts[text].firstMatch
        if element.waitForExistence(timeout: 60) {
            element.tap()
        } else {
            XCTFail("Fail to tap text")
        }
    }
    
    func isVisible(_ identifier: String) -> Bool {
        let element = staticTexts[identifier]
        return element.waitForExistence(timeout: 10)
    }
    
    func search(_ term: String) {
        let searchbarTextField = searchFields["Search"].firstMatch
        if searchbarTextField.waitForExistence(timeout: 10) {
            searchbarTextField.clearAndEnterText(text: term)
        } else {
            XCTFail("Fail to tap search bar")
        }
        
        let keyboardSearchButton = keyboards.buttons["Search"].firstMatch
        if keyboardSearchButton.waitForExistence(timeout: 60) {
            keyboardSearchButton.tap()
        } else {
            XCTFail("Fail to tap keyboard search button")
        }
    }
    
    func tapOnTextOnNavigationBar(_ staticText: String) {
        let element = navigationBars.staticTexts[staticText].firstMatch
        if element.waitForExistence(timeout: 10) {
            element.tap()
        } else {
            XCTFail("Fail to tap on \(staticText)")
        }
    }
    
}

extension XCUIElement {
    
    func clearAndEnterText(text: String) {
        guard let stringValue = value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        tap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        typeText(deleteString)
        typeText(text)
    }
    
}
