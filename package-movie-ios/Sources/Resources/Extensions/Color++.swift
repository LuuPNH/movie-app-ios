//
//  Color++.swift
//  
//
//  Created by Luu Phan on 28/02/2023.
//

import SwiftUI

extension Color: ExpressibleByStringInterpolation {
    public init(stringLiteral value: StringLiteralType) {
        self.init(.init(hexString: value))
    }
    
//    public var uiKit: UIColor {
//        return UIColor(self)
//    }
//
//    public static func opacity(_ opacity: Double) -> StringLiteralType {
//        let opacity = min(100, max(0, opacity)) * 255.0 / 100.0
//        var hex = String(Int(opacity.rounded()), radix: 16).uppercased()
//        if hex.count == 1 {
//            hex = "0" + hex
//        }
//        return hex
//    }
}
