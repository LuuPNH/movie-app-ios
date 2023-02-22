//
//  DIInitiallizer.swift
//  movie-app-ios
//
//  Created by Luu Phan on 10/01/2023.
//

import Foundation
import Domain
import Common
import DependencyKit
import Data

class DIInitializer: Initializable {
    func performInitialization() {
        Container.dataProvider = DataFactory()
    }
}


