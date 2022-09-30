//
//  UIApplication.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/24/22.
//

import Foundation
import SwiftUI
extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
