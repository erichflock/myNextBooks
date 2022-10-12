//
//  XCUIApplication+Extensions.swift
//  MyNextBooksUITests
//
//  Created by Erich Flock on 11.10.22.
//

import XCTest

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
            XCTFail("Fail to tap \(text)", line: #line)
        }
    }
    
    func isVisible(_ identifier: String) -> Bool {
        let element = staticTexts[identifier]
        return element.waitForExistence(timeout: 10)
    }
    
    func search(_ term: String) {
        let searchbarTextField = searchFields["Search"].firstMatch
        if searchbarTextField.waitForExistence(timeout: 60) {
            searchbarTextField.clearAndEnterText(text: term)
        } else {
            XCTFail("Fail to tap search bar")
        }
        
        let keyboardSearchButton = keyboards.buttons["Search"].firstMatch
        if keyboardSearchButton.waitForExistence(timeout: 60) {
            keyboardSearchButton.tap()
        } else {
            XCTFail("Fail to tap keyboard search button for term \(term)")
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
