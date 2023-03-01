//
//  UIColor++.swift
//  
//
//  Created by Luu Phan on 28/02/2023.
//

import SwiftUI

public extension UIColor {
    convenience init(hexString: String) {
        let value = hexString.uppercased()
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let start = value.index(value.startIndex, offsetBy: value.hasPrefix("#") ? 1 : 0)
        
        var hexColor = String(value[start...])
        if hexColor.count == 6 {
            hexColor.append("FF") //alpha = 1
        }
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        let mask: UInt64 = 0x000000FF
        if scanner.scanHexInt64(&hexNumber) {
            red = CGFloat(hexNumber >> 24 & mask) / 255.0
            green = CGFloat(hexNumber >> 16 & mask) / 255.0
            blue = CGFloat(hexNumber >> 8 & mask) / 255.0
            alpha = CGFloat(hexNumber & mask) / 255.0
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    var swiftUI: Color {
        return Color(self)
    }
    
}
