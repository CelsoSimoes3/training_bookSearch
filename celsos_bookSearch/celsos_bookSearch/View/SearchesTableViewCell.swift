//
//  SearchesTableViewCell.swift
//  celsos_bookSearch
//
//  Created by Celso Junio Simões de Oliveira Santos on 20/05/21.
//

import UIKit

class SearchesTableViewCell: UITableViewCell {

    @IBOutlet var bookNameLabelOutlet: UILabel!

    let searchCellIdentifier = "SearchCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupBookName(_ name: String) {
        bookNameLabelOutlet.text = name
    }
}
