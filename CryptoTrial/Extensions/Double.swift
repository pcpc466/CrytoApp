//
//  Double.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/16/22.
//

import Foundation


extension Double {
    
    /// converts a double into a currency with 2 decimal places 
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current //default value
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
//        formatter.currencyCode = "usd"  // In case you wanna change currency code
//        formatter.currencySymbol = "$" // In case you have changed the currency
       return formatter
    }
    
    
    ///converts 0.123456 to "$0.1233456" or 12.3456 to "$12.3456"
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    /// converts a double into a currency
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current //default value
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
//        formatter.currencyCode = "usd"  // In case you wanna change currency code
//        formatter.currencySymbol = "$" // In case you have changed the currency
       return formatter
    }
    
    
    ///converts 0.123456 to "$0.1233456" or 12.3456 to "$12.3456"
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter.string(from: number) ?? "$0.00"
    }
    
    ///converts 1.2345 to 1.23
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
 
    
    
    ///converts 1.2345 to 1.23%
    func asPercentString () -> String {
        return asNumberString() + "%"
    }
    
    
    ///
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
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


