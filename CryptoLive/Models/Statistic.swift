//
//  Statistic.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/10/23.
//

import Foundation

struct Statistic: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
    var unwrappedPercentage: Double {
        percentageChange ?? 0.0
    }
}
