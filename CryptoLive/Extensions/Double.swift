//
//  Double.swift
//  CryptoLive
//
//  Created by Dev Patel on 8/6/23.
//

import Foundation

extension Double {
    
    /// Converts a double into a currency with 2-6 decimal places
    ///  ```
    /// Convert 1234.56 to $1234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    ///  ```
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current // default value
//        formatter.currencyCode = "USD" // change currency
//        formatter.currencySymbol = "$" // change currency symbol
        formatter.minimumFractionDigits = 2
//        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Converts a double into a currency as a String with 2-6 decimal places
    ///  ```
    /// Convert 1234.56 to "$1234.56"
    ///  ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        let formatter = currencyFormatter
        formatter.maximumFractionDigits = 6
        return formatter.string(from: number) ?? "$0.00"
    }
    
    /// Converts a double into a currency as a String with 2 decimal places
    ///  ```
    /// Convert 1234.56 to "$1234.56"
    /// Convert 12.3456 to "$12.34"
    /// Convert 0.123456 to "$0.12"
    ///  ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        let formatter = currencyFormatter
        formatter.maximumFractionDigits = 2
        return formatter.string(from: number) ?? "$0.00"
    }
    
    /// Converts a double into a string representation
    ///  ```
    /// Convert 1.2345 to "1.23"
    ///  ```
    func asNumberString() -> String {
        String(format: "%.2f", self)
    }
    
    /// Converts a double into a string representation with percent symbol
    ///  ```
    /// Convert 1.2345 to "1.23%"
    ///  ```
    func asPercentString() -> String {
        asNumberString() + "%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M /I Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations () -> String {
        let num = abs (Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()
        default:
            return "\(sign)\(self)"
        }
        
    }
}
