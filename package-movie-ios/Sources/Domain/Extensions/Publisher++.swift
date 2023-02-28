//
//  Publisher++.swift
//  
//
//  Created by Luu Phan on 16/02/2023.
//

import Foundation
import Combine

public extension Publisher {
    func bind<Subject>(to subject: Subject, autoCancel: Bool = false) -> AnyCancellable
    where Subject: Combine.Subject, Subject.Output == Self.Output, Subject.Failure == Self.Failure {
        return receive(on: RunLoop.main)
            .sink { completion in
                if autoCancel {
                    subject.send(completion: completion)
                }
            } receiveValue: { value in
                subject.send(value)
            }
    }
    
    func receiveValue(_ action: @escaping (Output) -> Void) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveOutput: action)
            .eraseToAnyPublisher()
    }
    
    func unwrap<T>() -> AnyPublisher<T, Failure> where Output == T? {
        compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
}
