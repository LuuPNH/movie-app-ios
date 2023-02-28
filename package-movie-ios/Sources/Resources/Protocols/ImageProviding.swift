//
//  ImageProviding.swift
//  
//
//  Created by Luu Phan on 20/02/2023.
//

import SwiftUI
import UIKit

public protocol ImageProviding {
    var imageName: String { get }
    var imageBundle: Bundle { get }
}

public extension ImageProviding where Self: RawRepresentable, Self.RawValue == String {
    var imageName: String { rawValue }
}

public extension ImageProviding {
    func callAsFunction() -> Image {
        Image.load(imageName, bundle: imageBundle)
    }
    func callAsFunction() -> UIImage {
        UIImage.load(imageName, bundle: imageBundle)
    }
}
