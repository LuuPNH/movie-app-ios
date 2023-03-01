//
//  ColorProviding.swift
//  
//
//  Created by Luu Phan on 28/02/2023.
//

import SwiftUI

public protocol ColorProviding {
    var hexColor: String { get }
}

public extension ColorProviding where Self:RawRepresentable, Self.RawValue == String {
    var hexColor: String { rawValue }
}

public extension ColorProviding {
    func callAsFunction(_ opacity: Double = 1.0) -> Color {
        let color: Color = .init(stringLiteral: hexColor)
        return color.opacity(opacity)
    }
    
    func callAsFunction(_ alpha: Double = 1.0) -> UIColor {
        let color: UIColor = .init(hexString: hexColor)
        return color.withAlphaComponent(alpha)
    }
}
