//
//  service_bookSearchTests.swift
//  celsos_bookSearchTests
//
//  Created by Celso Junio Simões de Oliveira Santos on 17/06/21.
//

import XCTest
import PromiseKit
@testable import celsos_bookSearch

class MockGetService: GetService {
    override func getBooks(term: String) -> Promise<SearchResult> {
        let urlString = "https://itunes.apple.com/search?term=\(term)&entity=ibook"
        let url = URL(string: urlString)!

        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
        }.compactMap {
            return try JSONDecoder().decode(SearchResult.self, from: $0.data)
        }
    }
}

class ServiceBookSearchTests: XCTestCase {

    var getService: GetService!
    var mockGetService: MockGetService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        getService = GetService()
        mockGetService = MockGetService()
    }

    override func tearDownWithError() throws {
        getService = nil
        mockGetService = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testValidResponseWhenSearchAValidWord() throws {
        // given
        let expectation = XCTestExpectation(description: "Promise complete")
        let searchedWord = "Swift"

        // when
        mockGetService.getBooks(term: searchedWord)
            .done { weatherInfo in
                // then
                XCTAssertNotNil(weatherInfo)
                expectation.fulfill()
            }
            .catch { error in
                XCTFail(error.localizedDescription)
            }

        wait(for: [expectation], timeout: 10.0)
    }

    func testValidResponseWhenSearchAInvalidWord() throws {
        // given
        let exp = expectation(description: "Promise complete")
        let searchedWord = "#@%@$"

        // when
        getService.getBooks(term: searchedWord)
            .done { weatherInfo in
                // then
                XCTAssertNotNil(weatherInfo)
                exp.fulfill()
            }
            .catch { error in
                XCTFail(error.localizedDescription)
                exp.fulfill()
            }

        waitForExpectations(timeout: 5)
    }

    func testCatchPromiseKitResponseError() {
        let exp = expectation(description: "Promise complete")

        mockGetService.getBooks(term: "")
            .done { weatherInfo in
                // then
                XCTAssertNotNil(weatherInfo)
                exp.fulfill()
            }
            .catch { error in
                XCTFail(error.localizedDescription)
                exp.fulfill()
            }

        waitForExpectations(timeout: 5)
    }

}
