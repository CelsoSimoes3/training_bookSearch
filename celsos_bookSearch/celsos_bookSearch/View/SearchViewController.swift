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

    var searchesArray: [String] = []
    let searchCellNibName = "SearchesTableViewCell"
    let searchCellIdentifier = SearchesTableViewCell().searchCellIdentifier

    override func viewDidLoad() {
        super.viewDidLoad()
        searchesArray.append("Teste")

        //self.view.backgroundColor = .green
        self.title = "Teste Nav"

        recentSearchesTableViewOutlet.delegate = self
        recentSearchesTableViewOutlet.dataSource = self
        recentSearchesTableViewOutlet.reloadData()

        let searchCellNib = UINib(nibName: searchCellNibName, bundle: Bundle(for: SearchesTableViewCell.self))
        self.recentSearchesTableViewOutlet.register(searchCellNib, forCellReuseIdentifier:                        self.searchCellIdentifier)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Exntensions
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
