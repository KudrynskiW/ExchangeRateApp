//
//  ActivityIndicator.swift
//  ExchangeRate
//
//  Created by Wojciech Kudrynski on 31/01/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import UIKit

class ActivityIndicator {
    let view: UIView
    
    init(setupFor view: UIView) {
        self.view = view
    }
    
    func show() {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        activityView.startAnimating()
        self.view.addSubview(activityView)
    }
    
    func hide() {
        self.view.subviews.last?.removeFromSuperview()
    }
}
