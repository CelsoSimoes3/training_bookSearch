//
//  celsos_bookSearchTests.swift
//  celsos_bookSearchTests
//
//  Created by Celso Junio Simões de Oliveira Santos on 19/05/21.
//  swiftlint:disable type_name

import XCTest
@testable import celsos_bookSearch

class MockSearchesTableViewCell: SearchesTableViewCell {
    var bookName = UILabel()
    override func setupBookName(_ name: String) {
        bookName.text = name
    }
}

class celsos_bookSearchTests: XCTestCase {

    var sut: SearchViewController! // System Under Tests
    var searchViewModel: SearchViewModel!
    let searchBar = UISearchBar()

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SearchViewController() // Cria nossa instancia da SearchViewController para testes
        sut.viewDidLoad()
        searchViewModel = SearchViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        searchViewModel = nil
        try super.tearDownWithError()
    }

    func testValidSearchedWordBeingAddedToArray() throws {
        // given
        let searchedWord = "Test Save"

        // when
        searchBar.text = searchedWord
        sut.searchBarSearchButtonClicked(searchBar)

        // then
        XCTAssertNotNil(sut.searchViewModel.searchesArray)
        XCTAssertEqual(sut.searchViewModel.searchesArray[0], searchedWord)
    }

    func testInvalidSearchedWordNotBeingAddedToTableViewArray() throws {
        // given
        let searchedWord = ""

        // when
        // Trying to search an empty word
        searchBar.text = searchedWord
        sut.searchBarSearchButtonClicked(searchBar)

        // then
        XCTAssertTrue(sut.searchViewModel.searchesArray.isEmpty)
    }

    func testSetupCellLabelText() {
        // given
        let searchCell = SearchesTableViewCell()
        searchCell.bookNameLabelOutlet = UILabel()
        let searchedWord = "Test"

        // when
        searchCell.setupBookName(searchedWord)

        // then
        XCTAssertEqual(searchCell.bookNameLabelOutlet.text, searchedWord)

    }

    func testSetupCellLabelTextWithMock() {
        // given
        let searchCell = MockSearchesTableViewCell()
        searchCell.awakeFromNib()
        let searchedWord = "Test"

        // when
        searchCell.setupBookName(searchedWord)

        // then
        XCTAssertEqual(searchCell.bookName.text, searchedWord)

    }

}
