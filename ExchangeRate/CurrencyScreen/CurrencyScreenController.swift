//
//  CurrencyScreenController.swift
//  ExchangeRate
//
//  Created by Wojciech Kudrynski on 29/01/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation
import UIKit

class CurrencyScreenController: UIViewController, DatePickerDelegateCustom {
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var table: String = ""
    var code: String = ""
    var fromDate: String = ""
    var toDate: String = ""
    var differenceBetweenDates = 0
    var rates: [Currency] = []
    var changingFrom = false
    var today = ""
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchData))
        
        toDate = fromDate
        fromLabel.text = fromDate
        toLabel.text = fromLabel.text
        
        fetchData()
    }
    
    @objc func fetchData() {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        activityView.startAnimating()
        self.view.addSubview(activityView)
        let separator = "/"
        let category = "rates"
        let address = category + separator + table + separator + code + separator +
        fromDate + separator + toDate + separator
        ConnectionManager.shared().download(ext: address) { (res: Response?, err) in
            DispatchQueue.main.sync {
            if let error = err {
                self.rates = [Currency(no: nil, currency: nil, code: nil, bid: nil, ask: nil, mid: 0.0, effectiveDate: "")]
                self.tableView.reloadData()
                print("Error appear: \(error)")
                }
                if let res = res {
                    self.rates = res.rates
                    self.tableView.reloadData()
                }
                self.view.subviews.last?.removeFromSuperview()
            }
        }
    }
    
    func setupPickerView(min: String?, max: String?, starting: String) {
        let view = DatePickerController.instanceFromNib() as! DatePickerController
        view.delegate = self
        view.setup(min: min, max: max, starting: starting)
        self.view.addSubview(view)
    }
    
    @IBAction func fromButtonTapped(_ sender: Any) {
        setupPickerView(min: nil, max: toDate, starting: fromDate)
        changingFrom = true
    }
    
    @IBAction func toButtonTapped(_ sender: Any) {
        setupPickerView(min: fromDate, max: nil, starting: toDate)
    }
    
    func setDate(date: String) {
        self.view.subviews.last?.removeFromSuperview()
        if(changingFrom) {
            changingFrom = false
            self.fromDate = date
            self.fromLabel.text = date
        } else {
            self.toDate = date
            self.toLabel.text = date
        }
        fetchData()
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
