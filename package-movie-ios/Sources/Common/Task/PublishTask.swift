//
//  PublishTask.swift
//  
//
//  Created by Luu Phan on 20/02/2023.
//

import Foundation
import Combine
import Domain

public final class PublishTask: ObservableObject, ErrorHandling {
    
    public var cancellables = Set<AnyCancellable>()
    
    public var errorSubject: PassthroughSubject<Error, Never> = .init()
    
    var stream: PassthroughSubject<Any, Never> = .init()
    
    deinit {
        dLog("+++ \(self) deinit")
    }
    
    public init() { }
    
    public func callAsFunction<Output>(task: () -> AnyPublisher<Output, Error>) {
        task()
            .receive(on: RunLoop.current)
            .sink(receiveCompletion: { [weak self] complete in
                switch complete {
                case .failure(let err):
                    self?.errorSubject.send(err)
                default:
                    break
                }
            }, receiveValue: { [weak self] output in
                self?.stream.send(output)
            })
            .store(in: &cancellables)
    }
    
    public func callAsFunction(task: () -> AnyCancellable) {
        task()
            .store(in: &cancellables)
    }

    public func receive<Output>(_ type: Output.Type) -> AnyPublisher<Output, Never> {
        stream
            .share()
            .compactMap { $0 as? Output }
            .eraseToAnyPublisher()
    }

    public func cancel() {
        cancellables.removeAll()
    }
}
