//
//  CurrencyScreenController.swift
//  ExchangeRate
//
//  Created by Wojciech Kudrynski on 29/01/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation
import UIKit

class CurrencyScreenController: UIViewController {
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var table: String = ""
    var code: String = ""
    var fromDate: String = ""
    var toDate: String = ""
    var differenceBetweenDates = 0
    var rates: [Currency] = []
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchData))
        
        toDate = fromDate
        fromLabel.text = fromDate
        toLabel.text = fromLabel.text
        
        fetchData()
    }
    
    @objc func fetchData() {
        let separator = "/"
        let category = "rates"
        let address = category + separator + table + separator + code + separator +
        fromDate + separator + toDate + separator
        ConnectionManager.shared().downloadSingle(ext: address) { (response, error) in
            if let error = error {
                print("Error appear: \(error)")
            }
            DispatchQueue.main.sync {
                self.rates = response!.rates
                self.tableView.reloadData()
            }
        }
    }
    
}

extension CurrencyScreenController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ReuseCell")
        let currency = rates[indexPath.row]
        if let currency = currency.mid {
            cell.textLabel?.text = "Average: \(currency)"
        }
        if let currency = currency.ask {
            cell.textLabel?.text = "Average: \(currency)"
        }
        cell.detailTextLabel?.text = "Date: " + rates[indexPath.row].effectiveDate!
        return cell
    }
    
    
}
