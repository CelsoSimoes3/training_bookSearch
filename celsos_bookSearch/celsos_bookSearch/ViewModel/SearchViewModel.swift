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
    public var invalidWordAlertTitle = "Invalid Word"
    public var invalidWordAlertMessage = "Please enter a valid Book name"

    func validateSearchedWord(searchBarOutlet: UISearchBar) -> Bool {
        let nameRegex = "[A-Z0-9a-z .]{1,}" // Regex to prevent bad characters input
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegex)

        if let searchBarText = searchBarOutlet.text, !searchBarText.isEmpty,
           !searchesArray.contains(searchBarText), namePred.evaluate(with: searchBarText) {
            searchesArray.append(searchBarText)
            return true
        }
        return false
    }
}
