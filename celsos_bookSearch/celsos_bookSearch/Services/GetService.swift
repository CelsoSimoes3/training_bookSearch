//
//  GetService.swift
//  celsos_bookSearch
//
//  Created by Celso Junio Simões de Oliveira Santos on 21/05/21.
//

import Foundation
import PromiseKit

//class GetService
// TO DO
// Formato tirado de um POST. GET a construir
//class GetService {
//
//    static var baseURL = ""
//
//    func postLogin(_ emailText: String, _ passwordText: String) {
//
//        guard let url = URL(string: "\(GetService.baseURL)login") else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        let usuario = Book(from: <#Decoder#>)
//
//        guard let jsonData = try? JSONEncoder().encode(usuario) else { return }
//        request.httpBody = jsonData
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data,
//                  let response = response as? HTTPURLResponse,
//                  error == nil else { // check for fundamental networking error
//                print("error", error ?? "Unknown error")
//                return
//            }
//
//            guard (200 ... 299) ~= response.statusCode
//            else {  // check for http errors
//                return
//            }
//        }
//        task.resume()
//
//    }
//}
