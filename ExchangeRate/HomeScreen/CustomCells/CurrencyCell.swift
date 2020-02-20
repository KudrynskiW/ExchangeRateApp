//
//  CurrencyCell.swift
//  ExchangeRate
//
//  Created by Wojciech Kudrynski on 29/01/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation
import UIKit

class CurrencyCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var averageValueLabel: UILabel!
    
    func setupCell(_ date: String,_ currency: Currency) {
        self.layer.cornerRadius = 10
        
        self.dateLabel.text = date
        self.nameLabel.text = "\(currency.code ?? "") (\(currency.currency ?? ""))"
        if let currency = currency.mid {
            self.averageValueLabel.text = "\(currency)"
        }
        if let currency = currency.ask {
            self.averageValueLabel.text = "\(currency)"
        }
        

        
    }
    
}
