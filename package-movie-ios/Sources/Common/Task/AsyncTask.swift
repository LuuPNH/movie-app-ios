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
    
    public func callAsFunction(task: @escaping () async throws -> Void) {
        Task { @MainActor [weak self] in
            await self?.run(task: task)
        }
        .store(in: &cancellables)
    }
    @MainActor
    //unsing for .task in view
    public func run(task: @escaping () async throws -> Void) async {
        do {
            try await task()
        } catch {
            errorSubject.send(error)
        }
    }
    
    public func cancel() {
        cancellables.removeAll()
    }
}
