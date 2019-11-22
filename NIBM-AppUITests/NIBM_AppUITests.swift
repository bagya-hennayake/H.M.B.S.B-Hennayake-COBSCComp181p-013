//
//  NIBM_AppUITests.swift
//  NIBM-AppUITests
//
//  Created by Bagya Hennayake on 10/25/19.
//  Copyright © 2019 Bagya Hennayake. All rights reserved.
//

import XCTest

class NIBM_AppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
   
    
    
    func testExample() {
        let app = XCUIApplication()
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        let element = element2.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element.tap()
        
        let secureTextField = element.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.tap()
        app.buttons["LOGIN"].tap()
//        let app = XCUIApplication()
//           let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
//           element.children(matching: .textField).element.tap()
//
//           let secureTextField = element.children(matching: .secureTextField).element
//           secureTextField.tap()
//           secureTextField.tap()
//                   app.buttons["LOGIN"].tap()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
