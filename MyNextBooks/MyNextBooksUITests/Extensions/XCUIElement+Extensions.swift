//
//  XCUIElement+Extensions.swift
//  MyNextBooksUITests
//
//  Created by Erich Flock on 11.10.22.
//

import XCTest

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
