//
//  NetworkManager.swift
//  AssesmentApp
//
//  Created by Manish Sama on 10/25/19.
//  Copyright © 2019 Manish Sama. All rights reserved.
//

typealias SuccessFailureHandler = (Bool, [String:Any]?) -> ()

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {  }
    
    func makeANetworkCallFor(urlString: String, completionHandler: @escaping SuccessFailureHandler) {
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request) { (data, httpUrlResponse, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("error")
                    return
                }
                
                guard let httpResponse = httpUrlResponse as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    print("error")
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] {
                        completionHandler(true, json)
                    }
                } catch {
                    return
                }
            }
            }.resume()
    }
}
