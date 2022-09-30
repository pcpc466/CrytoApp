//
//  HapticManager.swift
//  CryptoTrial
//
//  Created by Prashant Singh chauhan on 9/7/22.
//

import Foundation
import SwiftUI

class hapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
