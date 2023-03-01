//
//  ThemeEnviromentKey.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import SwiftUI

@dynamicMemberLookup
public enum AppTheme: CaseIterable, Equatable {
    case dark
    case light

   public var value: Theme {
        switch self {
        case .dark:
           return DarkTheme()
        case .light:
           return LightTheme()
        }
    }

   public subscript<T>(dynamicMember keyPath: KeyPath<Theme, T>) -> T {
        return value[keyPath: keyPath]
    }
}

private struct ThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: AppTheme = .light
}

extension EnvironmentValues {
  public var theme: AppTheme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}
