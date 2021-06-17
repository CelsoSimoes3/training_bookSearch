//
//  SearchViewModel.swift
//  celsos_bookSearch
//
//  Created by Celso Junio Simões de Oliveira Santos on 19/05/21.
//

import Foundation
import UIKit

class SearchViewModel {
    public var searchesArray: [String] = []

    func validateSearchedWord(searchBarOutlet: UISearchBar) -> Bool {
        if let searchBarText = searchBarOutlet.text, !searchBarText.isEmpty, !searchesArray.contains(searchBarText) {
            searchesArray.append(searchBarText)
            return true
        }
        return false
    }

}
