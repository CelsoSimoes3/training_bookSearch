//
//  SearchViewController.swift
//  celsos_bookSearch
//
//  Created by Celso Junio Simões de Oliveira Santos on 19/05/21.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var recentSearchesTableViewOutlet: UITableView!

    // MARK: - Variables
    var searchesArray: [String] = []
    let searchCellNibName = "SearchesTableViewCell"
    let searchCellIdentifier = SearchesTableViewCell().searchCellIdentifier

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        searchBarOutlet.delegate = self

        recentSearchesTableViewOutlet.rowHeight = 44 // Prevents the Heigh Warning
        recentSearchesTableViewOutlet.delegate = self
        recentSearchesTableViewOutlet.dataSource = self
        recentSearchesTableViewOutlet.reloadData()

        let searchCellNib = UINib(nibName: searchCellNibName, bundle: Bundle(for: SearchesTableViewCell.self))
        self.recentSearchesTableViewOutlet.register(searchCellNib, forCellReuseIdentifier: self.searchCellIdentifier)
    }

    // MARK: - Methods
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchBarText = searchBarOutlet.text, !searchBarText.isEmpty, !searchesArray.contains(searchBarText) {
            searchesArray.append(searchBarText)
            recentSearchesTableViewOutlet.reloadData()
        }
        dismissKeyboard()
    }
}

// MARK: - Extensions
extension SearchViewController: UITableViewDelegate {}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = recentSearchesTableViewOutlet.dequeueReusableCell(withIdentifier: self.searchCellIdentifier, for: indexPath) as? SearchesTableViewCell else {
            return UITableViewCell()
        }

        cell.setupBookName(searchesArray[indexPath.row])
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate{}
