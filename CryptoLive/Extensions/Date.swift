//
//  Date.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/18/23.
//

import Foundation

extension Date {
    init(coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date.now
        
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortString() -> String {
        return shortFormatter.string(from: self)
    }
}
