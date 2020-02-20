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
    var activityIndicator: ActivityIndicator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Currency Monitor"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchData))
        self.navigationController?.navigationBar.tintColor = .white
        
        tableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        tableView.rowHeight = 70
        
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        tableTypes.forEach { key, value in
            segmentedControl.setTitle(value, forSegmentAt: key)
        }
        
        activityIndicator = ActivityIndicator(setupFor: self.view)
        fetchData()
    }
    
    @objc func fetchData() {
        activityIndicator!.show()
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
                self.activityIndicator!.hide()
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
