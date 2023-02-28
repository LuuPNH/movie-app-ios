//
//  Image++.swift
//  
//
//  Created by Luu Phan on 21/02/2023.
//

import SwiftUI

public extension Image {
    static func load(_ name: String, bundle: Bundle? = nil) -> Image {
        return Image(name, bundle: bundle)
    }
}
