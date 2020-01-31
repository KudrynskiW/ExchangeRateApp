//
//  Response.swift
//  ExchangeRate
//
//  Created by Wojciech Kudrynski on 29/01/2020.
//  Copyright © 2020 Wojciech Kudrynski. All rights reserved.
//

import Foundation

struct Response: Decodable {
    var table: String?
    var no: String?
    var code: String?
    var tradingDate: String?
    var effectiveDate: String?
    var rates: [Currency]
}
