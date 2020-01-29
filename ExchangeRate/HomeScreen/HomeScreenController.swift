//
//  HomeScreenController.swift
//  ExchangeRate
//
//  Created by Wojciech Kudrynski on 29/01/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation
import UIKit

class HomeScreenController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let tableTypes: [Int: String] = [0: "A", 1: "B", 2: "C"]
    var rates: [Currency] = []
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Currency Monitor"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        tableView.rowHeight = 100
        
        tableTypes.forEach { key, value in
            segmentedControl.setTitle(value, forSegmentAt: key)
        }
        
        fetchData()
    }
    
    func fetchData() {
        download { (response, error) in
            if let error = error {
                print("Error appear: \(error)")
            }
            DispatchQueue.main.async {
                response?.forEach({ (response) in
                    self.rates = response.rates
                    self.date = response.effectiveDate
                    self.tableView.reloadData()
                })
            }
            
        }
    }
    
    func download(completion: @escaping([Response]?, Error?) -> ()) {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        let selectedTitle = segmentedControl.titleForSegment(at: selectedIndex)!
        let url = URL(string: "https://api.nbp.pl/api/exchangerates/tables/" + selectedTitle)!
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
    
    
    
    @IBAction func tableSelected(_ sender: Any) {
        fetchData()
        tableView.reloadData()
    }
}

extension HomeScreenController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(rates.isEmpty) {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyCell
            let currency = rates[indexPath.row]
            cell.setupCell(date, currency)
            return cell
        }
    }
    
    
}
