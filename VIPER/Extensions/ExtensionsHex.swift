//
//  Extensions.swift
//  CryptoCrazy-VIPER
//
//  Created by Sabri Çetin on 29.08.2024.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init (hex : String) {
        var hexSantized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSantized = hexSantized.replacingOccurrences(of: "#", with: "")
        
        var rgb : UInt64 = 0
        Scanner(string: hexSantized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000 ) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00 ) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        let alpha = CGFloat(1.0)

        self.init(red : red , green: green , blue: blue , alpha: alpha)
    }
}
