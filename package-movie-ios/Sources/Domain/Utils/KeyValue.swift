//
//  File.swift
//  
//
//  Created by Luu Phan on 13/02/2023.
//

import Foundation

public protocol KeyValue: AnyObject {
    var onboarding: ShowOnboarding? { get set }
    
    func clear()
}
