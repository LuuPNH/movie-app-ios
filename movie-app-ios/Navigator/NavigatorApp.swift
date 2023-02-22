//
//  NavigatorApp.swift
//  movie-app-ios
//
//  Created by Luu Phan on 11/01/2023.
//

import Foundation
import Common
import Combine

class NavigatorApps: Navigator, ObservableObject, Stepper {
    func go(to step: Common.Step) {
    }
    
    var canclelabels = Set<AnyCancellable>()
    
    var steps = PassthroughSubject<Common.Step, Never>()
    
}
