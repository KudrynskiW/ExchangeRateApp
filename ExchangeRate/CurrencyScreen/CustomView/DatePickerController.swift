//
//  DatePickerController.swift
//  ExchangeRate
//
//  Created by Wojciech Kudrynski on 29/01/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation
import UIKit

protocol DatePickerDelegateCustom {
    func setDate(date: String)
}

class DatePickerController: UIView {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var setDateButton: UIButton!
    
    var delegate: DatePickerDelegateCustom?
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "DatePickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(min: String?, max: String?) {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        setDateButton.tintColor = .white
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let min = min {
            datePicker.minimumDate = dateFormatter.date(from:min)!
        }
        if let max = max {
            datePicker.maximumDate = dateFormatter.date(from:max)!
        } else {
            datePicker.maximumDate = Date()
        }
        
         //[...] przy czym pojedyncze zapytanie nie może obejmować przedziału dłuższego, niż 93 dni.

    }
    
   
    
    @IBAction func setDateButtonClicked(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        delegate?.setDate(date: dateFormatter.string(from: datePicker!.date))
    }
    
    
    
}
