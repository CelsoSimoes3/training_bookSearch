//
//  GetService.swift
//  celsos_bookSearch
//
//  Created by Celso Junio Simões de Oliveira Santos on 21/05/21.
// swiftlint:disable all

import Foundation
import PromiseKit

class Services {
    func getBooks(term: String) -> Promise<SearchResult> {
        let urlString = "https://itunes.apple.com/search?term=\(term)&entity=ibook"
        let url = URL(string: urlString)!

        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
        }.compactMap {
            return try JSONDecoder().decode(SearchResult.self, from: $0.data)
        }
    }
}

