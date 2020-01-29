//
//  ConnectionManager.swift
//  ExchangeRate
//
//  Created by Wojciech Kudrynski on 29/01/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation

class ConnectionManager {
    private static let sharedConnectionManager = ConnectionManager()
    
    private init() {}
    
    func download(ext: String, completion: @escaping([Response]?, Error?) -> ()) {
        let url = URL(string: "https://api.nbp.pl/api/exchangerates/" + ext)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            } else {
                if let data = data {
                    do {
                        let resp = try JSONDecoder().decode([Response].self, from: data)
                        completion(resp, nil)
                    } catch let JsonError {
                        completion(nil, JsonError)
                    }
                }
            }
        }.resume()
    }
    
    func downloadSingle(ext: String, completion: @escaping(Response?, Error?) -> ()) {
        let url = URL(string: "https://api.nbp.pl/api/exchangerates/" + ext)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            } else {
                if let data = data {
                    do {
                        let resp = try JSONDecoder().decode(Response.self, from: data)
                        completion(resp, nil)
                    } catch let JsonError {
                        completion(nil, JsonError)
                    }
                }
            }
        }.resume()
    }
    
    class func shared() -> ConnectionManager {
        return sharedConnectionManager
    }
}
