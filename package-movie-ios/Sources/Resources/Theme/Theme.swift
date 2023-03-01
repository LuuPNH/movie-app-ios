//
//  Theme.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import SwiftUI

public protocol Theme {
    var name: String { get }
    
    var whiteShades: Color { get }
    var blackShades: Color { get }
    var blue2B5876: Color { get }
    var purple4E4376: Color { get }
}
