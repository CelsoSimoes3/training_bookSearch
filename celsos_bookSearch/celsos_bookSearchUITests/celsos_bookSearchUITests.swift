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

        // given
        let app = XCUIApplication()
        app.launchArguments = ["-runningUITests"]
        app.launch()

        // when
        let searchWord = "Swift"
        let searchTextField = app.searchFields["Apple Books"]

        searchTextField.tap()
        searchTextField.typeText(searchWord)

        app.keyboards.buttons["Search"].tap()
        app.navigationBars.buttons["BackToSearchViewButton"].tap() // Using AccessibilityIdentifier

        // then
        XCTAssertTrue(app.tables.cells.staticTexts["Swift"].exists)
    }

    // MARK: - OBS.: Following tests only work with the Keyboard active in Simulator
    func testSearchBarSearchButtonTapDidNotAddEmptyTextOnTableView() {

        let app = XCUIApplication()
        app.launchArguments = ["-runningUITests"]
        app.launch()

        let searchField = app.searchFields["Apple Books"]
        searchField.tap()
        app.keyboards.buttons["Search"].tap() // Without entering a valid word
        XCTAssertFalse(app.tables.cells.staticTexts[""].exists)
    }

    func testAlertShowsUpWhenInsertInvalidWordInSearchBar() {

        // Case 1 - Empty Search
        let app = XCUIApplication()
        app.launchArguments = ["-runningUITests"]
        app.launch()

        let searchField = app.searchFields["Apple Books"]
        searchField.tap()
        let searchButton = app.keyboards.buttons["Search"]
        searchButton.tap()

        let invalidWordAlert = app.alerts["Invalid Word"]

        XCTAssertTrue(invalidWordAlert.exists)
        invalidWordAlert.buttons["Ok"].tap()

        // Case 2 - Bad character input
        let invalidWord = "@*#&"
        searchField.tap()
        searchField.typeText(invalidWord)
        searchButton.tap()

        XCTAssertTrue(invalidWordAlert.exists)
        XCTAssertTrue(invalidWordAlert.buttons["Ok"].exists)

    }
}
