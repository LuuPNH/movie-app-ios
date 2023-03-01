//
//  ThemeManager.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation
import Combine
import Resources

public class ThemeManager {
    public static let shared = ThemeManager()

    private init() {}

    public var themePublisher: CurrentValueSubject<AppTheme, Never> = .init(.light)

    public func set(_ theme: AppTheme) {
        themePublisher.send(theme)
    }

    public func get() -> AppTheme {
        return themePublisher.value
    }
}
