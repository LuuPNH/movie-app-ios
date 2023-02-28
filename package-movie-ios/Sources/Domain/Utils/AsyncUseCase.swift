//
//  File.swift
//  
//
//  Created by Luu Phan on 10/01/2023.
//

import Foundation

@available(iOS 13, *)
public protocol AsyncUseCase {
    associatedtype Input
    associatedtype Output

    func callAsFunction(_ input: Input) async throws -> Output
    func onCleared()
}

@available(iOS 13, *)
public extension AsyncUseCase {
    func onCleared() {}
}

@available(iOS 13, *)
public extension AsyncUseCase where Input == Void {
    func callAsFunction() async throws -> Output {
        return try await self(())
    }
}
