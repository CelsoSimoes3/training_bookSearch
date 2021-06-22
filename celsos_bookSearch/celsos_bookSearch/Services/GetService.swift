//
//  GetService.swift
//  celsos_bookSearch
//
//  Created by Celso Junio Simões de Oliveira Santos on 21/05/21.
// swiftlint:disable all

import Foundation
import PromiseKit

class GetService {

    private var urlSession: UrlSessionProtocol
    private var serviceError = ServiceError.self

    init(urlSession: UrlSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func getBooks(term: String) -> Promise<SearchResult> {
        // Solution for: Term with blank spaces between words
        let termWithoutSpaces = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let urlString = "https://itunes.apple.com/search?term=\(termWithoutSpaces ?? "")&entity=ibook"


        guard let url = URL(string: urlString) else { return Promise.init(error: serviceError.urlMalFormatted)}

        return firstly {
            urlSession.dataTask(.promise, with: url)
        }.compactMap {
            return try JSONDecoder().decode(SearchResult.self, from: $0.data)
        }
    }
}

protocol UrlSessionProtocol {
    func dataTask(_: PMKNamespacer, with convertible: URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)>
}
