//
//  String.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 9/17/22.
//

import Foundation

extension String {
    
    var removingHTML: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "",options: .regularExpression, range: nil)
    }
}
