//
//  Error.swift
//  
//
//  Created by Luu Phan on 27/04/2023.
//

import Foundation
import Combine
import SwiftUI

public final class AppError<AppError: Error>: ObservableObject {
    
    let errorSubject = PassthroughSubject<AppError, Never>()
    
    public var errors: [Error] = []
    
    public var stream: AnyPublisher<AppError, Never> {
        errorSubject.share().eraseToAnyPublisher()
    }
    
    deinit { print("++ AppError deinit ++") }
    
    public init() {}
    
    public func pushError(to error: AppError) {
        errors.append(error)
        errorSubject.send(error)
    }
    
    public func inject(from subject: PassthroughSubject<AppError, Never>) -> AnyCancellable {
        subject.bind(to: errorSubject)
    }
    
    public func clearError() { errors.removeAll() }
}
