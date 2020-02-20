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
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ReuseCell")
        cell.backgroundColor = UIColor(named: "cell_background")
        let currency = rates[indexPath.section]
        if let currency = currency.mid {
            cell.textLabel?.text = "Average: \(currency)"
        }
        if let currency = currency.ask {
            cell.textLabel?.text = "Average: \(currency)"
        }
        cell.detailTextLabel?.text = "Date: " + rates[indexPath.row].effectiveDate!
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "background")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
