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
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyCell
        let currency = rates[indexPath.section]
        cell.setupCell(date, currency)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIStoryboard(name: "CurrencyScreenView", bundle: nil).instantiateViewController(withIdentifier: "CurrencyScreenView") as! CurrencyScreenController
        vc.title = rates[indexPath.section].currency
        vc.table = selectedTable
        vc.code = rates[indexPath.section].code!
        vc.fromDate = date
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "background")
        return headerView
    }
    
}

