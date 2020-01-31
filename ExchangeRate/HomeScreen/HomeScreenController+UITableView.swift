//
//  HomeScreenController+UITableView.swift
//  ExchangeRate
//
//  Created by Wojciech Kudrynski on 31/01/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import UIKit

extension HomeScreenController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyCell
        let currency = rates[indexPath.row]
        cell.setupCell(date, currency)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "CurrencyScreenView", bundle: nil).instantiateViewController(withIdentifier: "CurrencyScreenView") as! CurrencyScreenController
        vc.title = rates[indexPath.row].currency
        vc.table = selectedTable
        vc.code = rates[indexPath.row].code!
        vc.fromDate = date
        navigationController?.pushViewController(vc, animated: true)
    }
}

