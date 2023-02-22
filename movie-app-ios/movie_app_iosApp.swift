//
//  movie_app_iosApp.swift
//  movie-app-ios
//
//  Created by Luu Phan on 09/01/2023.
//

import SwiftUI
import Common
import UI
import DependencyKit

@main
struct movie_app_iosApp: App {
    
    lazy var initializers: [Initializable] = [
        DIInitializer() // must be the first item
    ]
    
    init() {
        self.initializers.forEach {
            $0.performInitialization()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentContainerView()
        }
    }
}
