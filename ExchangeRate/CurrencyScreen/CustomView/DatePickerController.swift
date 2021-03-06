//
//  DatePickerController.swift
//  ExchangeRate
//
//  Created by Wojciech Kudrynski on 29/01/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation
import UIKit

protocol DatePickerDelegateCustom: class {
    func setDate(date: String)
}

class DatePickerController: UIView {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var setDateButton: UIButton!
    
    weak var delegate: DatePickerDelegateCustom?
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "DatePickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setup(min: String?, max: String?, starting: String) {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        setDateButton.tintColor = .white
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        datePicker.date = dateFormatter.date(from: starting)!
        datePicker.minimumDate = min != nil ? dateFormatter.date(from:min!)! : nil
        datePicker.maximumDate = max != nil ? dateFormatter.date(from:max!)! : Date()
    }
    
    @IBAction func setDateButtonClicked(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        delegate?.setDate(date: dateFormatter.string(from: datePicker!.date))
    }
    
    
    
}
