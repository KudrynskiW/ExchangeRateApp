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
    var selectedTable = "A"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Currency Monitor"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchData))
        
        tableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        tableView.rowHeight = 100
        
        tableTypes.forEach { key, value in
            segmentedControl.setTitle(value, forSegmentAt: key)
        }
        fetchData()
    }
    
    @objc func fetchData() {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        activityView.startAnimating()
        self.view.addSubview(activityView)
        let category = "tables/"
        

        ConnectionManager.shared().download(ext: category + selectedTable) { (res: [Response]?, err) in
            DispatchQueue.main.sync {
                if let err = err {
                    print("Error appear: \(err)")
                }
                res?.forEach({ (response) in
                    self.rates = response.rates
                    self.date = response.effectiveDate!
                    self.tableView.reloadData()
                    })
                self.view.subviews.last?.removeFromSuperview()
                }
            }
        }
        
    
    @IBAction func tableSelected(_ sender: Any) {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        selectedTable = segmentedControl.titleForSegment(at: selectedIndex)!
        fetchData()
        tableView.reloadData()
    }
}

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
