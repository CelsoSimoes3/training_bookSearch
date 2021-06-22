//
//  UIViewControlerExtensions.swift
//  celsos_bookSearch
//
//  Created by Celso Junio Simões de Oliveira Santos on 16/06/21.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, titleAction: String = "Ok") {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: titleAction,
                                     style: .default)
        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)
    }
}
