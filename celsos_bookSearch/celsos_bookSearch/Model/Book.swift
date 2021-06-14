//
//  Book.swift
//  celsos_bookSearch
//
//  Created by Celso Junio Simões de Oliveira Santos on 21/05/21.
//

import Foundation

public struct Book: Decodable, Encodable {
    var artworkUrl60: String?
    var artworkUrl100: String?
    var trackName: String?
    var trackId: Int?
    var formattedPrice: String?
    var releaseDate: String?
    var artistName: String?
    var genres: [String]?
    var description: String?
    var averageUserRating: Float?
    var userRatingCount: Int?
}
