//
//  service_bookSearchTests.swift
//  celsos_bookSearchTests
//
//  Created by Celso Junio Simões de Oliveira Santos on 17/06/21.
//  swiftlint:disable line_length

import XCTest
import PromiseKit
@testable import celsos_bookSearch

class MockGetService: GetService {
    override func getBooks(term: String) -> Promise<SearchResult> {
        let urlString = "https://itunes.apple.com/search?ter"
        let url = URL(string: urlString)!

        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
        }.compactMap {
            return try JSONDecoder().decode(SearchResult.self, from: $0.data)
        }
    }
}

class MockURLSession: UrlSessionProtocol {
    func dataTask(_: PMKNamespacer, with convertible: URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)> {
        return Promise.init(error: ServiceError.internetConnectionError)
    }
}

class ServiceBookSearchTests: XCTestCase {

    var getService: GetService!
    var mockGetService: MockGetService!

    override func setUp() {
        getService = GetService()
        mockGetService = MockGetService()
    }

    override func tearDown() {
        getService = nil
        mockGetService = nil
    }

    func testPromiseResponseWhenSearchASingleWord() throws {
        // given
        let exp = expectation(description: "Promise complete")
        let searchedWord = "Swift"

        // when
        getService.getBooks(term: searchedWord)
            .done { data in
                // then
                XCTAssertNotNil(data)
                exp.fulfill()
            }
            .catch { error in
                XCTFail(error.localizedDescription)
                exp.fulfill()
            }

        waitForExpectations(timeout: 5)
    }

    func testPromiseResponseWhenSearchAPhrase() throws {
        // given
        let exp = expectation(description: "Promise complete")
        let searchedWord = "Swift and Tests"

        // when
        getService.getBooks(term: searchedWord)
            .done { data in
                // then
                XCTAssertNotNil(data)
                exp.fulfill()
            }
            .catch { error in
                XCTFail(error.localizedDescription)
            }

        waitForExpectations(timeout: 5)
    }

    func testPromiseResponseValuesWhenSearchACommonWord() throws {
        // given
        let exp = expectation(description: "Promise complete")
        let searchedWord = "Swift"

        // when
        getService.getBooks(term: searchedWord)
            .done { data in
                // then
                XCTAssertNotNil(data)
                XCTAssertEqual(data.resultCount, 50)
                XCTAssertEqual(data.results?.isEmpty, false)
                exp.fulfill()
            }
            .catch { error in
                XCTFail(error.localizedDescription)
            }

        waitForExpectations(timeout: 5)
    }

    func testPromiseCatchWhenAnErrorOccur() throws {
        // given
        let exp = expectation(description: "Promise complete")
        let searchedWord = "Swift"
        getService = GetService(urlSession: MockURLSession()) // Redefinition of GetService with Mock

        // when
        getService.getBooks(term: searchedWord)
            .done { _ in
                XCTFail("Promise didn't fail when it supposed to")
            }
            .catch { error in
                // then
                XCTAssertNotNil(error)
                XCTAssertEqual("\(error)", "\(ServiceError.internetConnectionError)")
                exp.fulfill()
            }

        waitForExpectations(timeout: 5)
    }

}
