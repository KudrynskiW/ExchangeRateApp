//
//  Currency.swift
//  ExchangeRate
//
//  Created by Wojciech Kudrynski on 29/01/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation

struct Currency: Decodable {
    var no: String? = ""
    var currency: String?
    var code: String?
    var bid: Double?
    var ask: Double?
    var mid: Double?
    var effectiveDate: String?
}
