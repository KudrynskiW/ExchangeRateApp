//
//  CurrencyScreenController+UITableView.swift
//  ExchangeRate
//
//  Created by Wojciech Kudrynski on 31/01/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import UIKit

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
