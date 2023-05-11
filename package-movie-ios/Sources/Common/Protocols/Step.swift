//
//  Step.swift
//  
//
//  Created by Luu Phan on 16/02/2023.
//

import Foundation
import Combine
import Domain

public protocol Step {}

public extension Step {
    static func router() -> Router<Self> {
        return .init()
    }
}

public struct NoneStep: Step {}

public final class Router<Route: Step>: ObservableObject {
    let routeSubject = PassthroughSubject<Route, Never>()
    
    public var stream: AnyPublisher<Route, Never> {
        routeSubject.share().eraseToAnyPublisher()
    }
    
    deinit {
        dLog("+++ \(self) +++")
    }
    
    public init() {}
    
    public func go(to route: Route?) {
        if route == nil { return }
        routeSubject.send(route!)
    }
    
    public func inject(from subject: PassthroughSubject<Route, Never>) -> AnyCancellable {
        subject.bind(to: routeSubject)
    }
}
