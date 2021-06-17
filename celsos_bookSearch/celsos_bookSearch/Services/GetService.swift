//
//  GetService.swift
//  celsos_bookSearch
//
//  Created by Celso Junio Simões de Oliveira Santos on 21/05/21.
// swiftlint:disable all

import Foundation
import PromiseKit

class GetService {
    func getBooks(term: String) -> Promise<SearchResult> {
        // Solution for: Term with blank spaces between words
        let termWithoutSpaces = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        // Another approach:
        //let termWithoutSpaces:String = term.replacingOccurrences(of: " ", with: "%20")
        
        let urlString = "https://itunes.apple.com/search?term=\(termWithoutSpaces ?? "")&entity=ibook"
        let url = URL(string: urlString)!

        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
        }.compactMap {
            return try JSONDecoder().decode(SearchResult.self, from: $0.data)
        }
    }
}

