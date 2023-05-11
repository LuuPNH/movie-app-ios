//
//  AsyncTask.swift
//  
//
//  Created by Luu Phan on 20/02/2023.
//

import Foundation
import Domain
import Combine

public final class AsyncTask: ObservableObject, ErrorHandling {
    
    public var cancellables = Set<AnyCancellable>()
    
    public var errorSubject: PassthroughSubject<Error, Never> = .init()
    
    public init() {}
    
    deinit {
        dLog("+++ \(self) deinit")
    }
    
    public func callAsFunction(task: @escaping () async throws -> Void, onFinished: @escaping () -> Void = {}) {
            Task { @MainActor [weak self] in
                await self?.run(task: task, onFinished: onFinished)
            }
            .store(in: &cancellables)
        }

        @MainActor
        // using for .task in view
        public func run(task: @escaping () async throws -> Void, onFinished: @escaping () -> Void = {}) async {
            do {
                try await task()
                onFinished()
            } catch {
                errorSubject.send(error)
                onFinished()
            }
        }
    
    public func cancel() {
        cancellables.removeAll()
    }
}
