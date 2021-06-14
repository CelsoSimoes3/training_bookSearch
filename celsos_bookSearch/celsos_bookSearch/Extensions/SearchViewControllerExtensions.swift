//
//  SearchViewControllerExtensions.swift
//  celsos_bookSearch
//
//  Created by Celso Junio Simões de Oliveira Santos on 14/06/21.
//

import UIKit

// MARK: - Extensions
extension SearchViewController: UITableViewDelegate {}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.searchesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = recentSearchesTableViewOutlet.dequeueReusableCell(
                withIdentifier: self.searchCellIdentifier,
                for: indexPath) as? SearchesTableViewCell
        else {
            return UITableViewCell()
        }

        cell.setupBookName(searchViewModel.searchesArray[indexPath.row])
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {}
