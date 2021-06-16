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
    let service = Services()
    var searchViewModel = SearchViewModel()
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
        if searchViewModel.validateSearchedWord(searchBarOutlet: searchBar) {
            recentSearchesTableViewOutlet.reloadData()
            goToResultsPage(searchBar.text!)
        } else {
            self.showAlert(title: searchViewModel.invalidWordAlertTitle, message: searchViewModel.invalidWordAlertMessage)
        }
        dismissKeyboard()
    }

    // MARK: - To Do:
    // 1 - Prevent error from: a searched word with blank spaces between words - DONE
    // 1.2 - Prevent Error with Special characters: '@#$%%@#*'. A Regex could be one approach - DONE
    // 2 - Finish goToResultsPage function
    // 3 - Make the Results page with an interactive Table View

    func goToResultsPage(_ term: String) {
        service.getBooks(term: term)
            .done { [weak self] weatherInfo in
                // Pass Data here
                // Segue here (Optional, can do it in another func too
                print(weatherInfo)
            }
            .catch { [weak self] error in
              guard let self = self else { return }

                // Make an alert for cases where no results were found
                print(error)
            }
    }
}

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
