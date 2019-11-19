//
//  CounterUITests.swift
//  CounterUITests
//
//  Created by Tony Tang on 11/17/19.
//  Copyright © 2019 TonyTang. All rights reserved.
//

import XCTest

class CounterUITests: XCTestCase {

    func localized(_ key: String) -> String {
        let uiTestBundle = Bundle(for: CounterUITests.self)
        return NSLocalizedString(key, bundle: uiTestBundle, comment: "")
    }

//    override func setUp() {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        let app = XCUIApplication()
//        setupSnapshot(app)
//        app.launch()
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        snapshot("01InitialScreen")
        let button = app.buttons["+ 1"]
        button.tap()
        button.tap()
        button.tap()
        button.tap()
        button.tap()
        button.tap()
        
        snapshot("02CountedScreen")
        
        print("\n\nLocalization for Clear: \(localized("Clear"))")
        let clearButton = app.buttons[localized("Clear")]
        clearButton.tap()
        
        let button2 = app.buttons["1x"]
        button2.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).buttons["1x"].tap()
        button.tap()
        button.tap()
        button.tap()
        button.tap()
        button.tap()
        button.tap()
        button2.tap()
        
        let button3 = app.buttons["10x"]
        button3.tap()
        
        let button4 = app.buttons["+ 10"]
        button4.tap()
        button4.tap()
        button4.tap()
        button4.tap()
        button4.tap()
        button4.tap()
        button3.tap()
        app.buttons["100x"].tap()
        
        let button5 = app.buttons["+ 100"]
        button5.tap()
        button5.tap()
        button5.tap()
        button5.tap()
        button5.tap()
        button5.tap()
        clearButton.tap()
        app.buttons["100x"].tap()
        button3.tap()
        button4.tap()
        button4.tap()
        button4.tap()
        button3.tap()
        app.buttons["3x"].tap()
        
        let button6 = app.buttons["+ 3"]
        button6.tap()
        button6.tap()
        button6.tap()
        clearButton.tap()
        app.buttons["History"].tap()
        
        snapshot("03HistoryScreen")
        
        let backStaticText = app.staticTexts["Back"]
        backStaticText.tap()
        app.buttons["Settings"].tap()
        
        snapshot("04SettingsScreen1")
        
        let tablesQuery = app.tables
        tablesQuery.children(matching: .cell).element(boundBy: 1).children(matching: .collectionView).element.swipeLeft()
        tablesQuery.children(matching: .other)["ABOUT"].children(matching: .other)["ABOUT"].swipeDown()
        app.tables.containing(.other, identifier:"FUNCTIONS").element.swipeDown()
//        snapshot("05SettingsScreen2")
        backStaticText.tap()
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//    func testLaunchPerformance() {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
