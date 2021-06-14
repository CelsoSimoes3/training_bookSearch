//
//  SearchResult.swift
//  celsos_bookSearch
//
//  Created by Celso Junio Simões de Oliveira Santos on 21/05/21.
//

import Foundation

public struct SearchResult: Codable {
    var resultCount: Int
    var results: [Book]?
}
