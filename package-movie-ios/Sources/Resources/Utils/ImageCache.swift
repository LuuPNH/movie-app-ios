//
//  ImageCache.swift
//  
//
//  Created by Luu Phan on 06/04/2023.
//

import Foundation
import SwiftUI

public class ImageCache: ObservableObject {
    private let cache = NSCache<NSString, UIImage>()
    
    public init() {}
    
    public func get(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    public func set(key: String, image: UIImage) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    public func remove(key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}




