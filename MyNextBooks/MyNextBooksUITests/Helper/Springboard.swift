//
//  Springboard.swift
//  MyNextBooksUITests
//
//  Created by Erich Flock on 10.10.22.
//

import XCTest

final class Springboard {

    private static var springboardApp = XCUIApplication(bundleIdentifier: "com.apple.springboard")

    static func deleteApp() {
        springboardApp.activate()
        
        let appIcon = springboardApp.icons.matching(identifier: "MyNextBooks").firstMatch
        if appIcon.waitForExistence(timeout: 60) {
            appIcon.press(forDuration: 0.5)
        } else {
            XCTFail("Fail to long press MyNextBooks app")
        }
        
        let removeAppButton = springboardApp.buttons["Remove App"]
        if removeAppButton.waitForExistence(timeout: 60) {
            removeAppButton.tap()
        } else {
            XCTFail("Fail to tap remove app button")
        }
        
        let appDeleteButton = springboardApp.alerts.buttons["Delete App"].firstMatch
        if appDeleteButton.waitForExistence(timeout: 10) {
            appDeleteButton.tap()
        } else {
            XCTFail("Fail to tap app delete button")
        }
        
        let deleteButton = springboardApp.alerts.buttons["Delete"].firstMatch
        if deleteButton.waitForExistence(timeout: 10) {
            deleteButton.tap()
        } else {
            XCTFail("Fail to tap delete button")
        }
    }
}
