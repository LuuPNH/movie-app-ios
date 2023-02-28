//
//  UIImages++.swift
//  
//
//  Created by Luu Phan on 20/02/2023.
//

import SwiftUI

public extension UIImage {
    static func load(_ name: String, bundle: Bundle? = nil) -> UIImage {
        return UIImage(named: name, in: bundle, compatibleWith: nil) ?? UIImage()
    }
}
