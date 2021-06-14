//
//  celsos_bookSearchUITests.swift
//  celsos_bookSearchUITests
//
//  Created by Celso Junio Simões de Oliveira Santos on 19/05/21.
//  swiftlint:disable type_name

import XCTest

class celsos_bookSearchUITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    func testSearchBarSearchButtonTapAddItemOnTableView() {

        let app = XCUIApplication()
        app.launchArguments = ["-runningUITests"]
        app.launch()

        let searchTextField = app.searchFields["Apple Books"]
        searchTextField.tap()
        searchTextField.typeText("Swift")
        app.keyboards.buttons["Search"].tap()
        XCTAssertTrue(app.tables.cells.staticTexts["Swift"].exists)
    }

    func testSearchBarSearchButtonTapDidNotAddEmptyTextOnTableView() {

        let app = XCUIApplication()
        app.launchArguments = ["-runningUITests"]
        app.launch()

        let searchField = app.searchFields["Apple Books"]
        searchField.tap()
        app.keyboards.buttons["Search"].tap()
        XCTAssertFalse(app.tables.cells.staticTexts[""].exists)
    }
}
