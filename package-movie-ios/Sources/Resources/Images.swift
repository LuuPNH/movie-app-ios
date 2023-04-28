//
//  Images.swift
//  
//
//  Created by Luu Phan on 20/02/2023.
//

import SwiftUI

public enum AppImages: String, ImageProviding {
    
    case image
    case logoNetflix = "LogoNetflix"
    case onboarding = "onboarding"
    case thor = "thor"
    case ironman = "ironman"
    case deadpool = "deadpool"
    case error = "error"
    
    public var imageBundle: Bundle { .resources }
}
