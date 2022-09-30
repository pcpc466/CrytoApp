//
//  Color.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 8/16/22.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color ("SecondaryTextColor")
    let focus = Color("FocusColor")
}
