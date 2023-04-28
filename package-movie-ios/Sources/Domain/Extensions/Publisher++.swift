//
//  Publisher++.swift
//  Common
//
//  Created by Phat Le on 29/04/2022.
//

import Combine
import Foundation

public extension Publisher {
    func unwrap<T>() -> AnyPublisher<T, Failure> where Output == T? {
        compactMap { $0 }
            .eraseToAnyPublisher()
    }

    func combineLatest<P, Q, R, Y, T>(_ publisher1: P, _ publisher2: Q, _ publisher3: R, _ publisher4: Y, _ transform: @escaping (Self.Output, P.Output, Q.Output, R.Output, Y.Output) -> T) -> AnyPublisher<T, Self.Failure> where P: Publisher, Q: Publisher, R: Publisher, Y: Publisher, Self.Failure == P.Failure, P.Failure == Q.Failure, Q.Failure == R.Failure, R.Failure == Y.Failure {
        Publishers.CombineLatest(combineLatest(publisher1, publisher2, publisher3), publisher4)
            .map { tuple, publisher4Value in
                transform(tuple.0, tuple.1, tuple.2, tuple.3, publisher4Value)
            }
            .eraseToAnyPublisher()
    }

    func ignoreResult() -> AnyCancellable {
        return sink { result in
            //
        } receiveValue: { value in
            //
        }
    }

    func receiveValue(_ action: @escaping (Output) -> Void) -> AnyCancellable {
        return sink { result in
            switch result {
            case .failure(let error):
                dLog(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: { value in
            action(value)
        }
    }

    func receiveValue(_ action: @escaping (Output) -> Void) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveOutput: action)
            .eraseToAnyPublisher()
    }

    func receiveCompletion(_ action: @escaping (Subscribers.Completion<Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: action) { _ in }
    }

    func receiveCompletion(_ action: @escaping (Subscribers.Completion<Failure>) -> Void) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: action)
            .eraseToAnyPublisher()
    }

    func bind<Subject>(to subject: Subject, autoCancel: Bool = false) -> AnyCancellable where Subject: Combine.Subject, Subject.Output == Self.Output, Subject.Failure == Self.Failure {
        return receive(on: RunLoop.main)
            .sink { completion in
                if autoCancel {
                    subject.send(completion: completion)
                }
            } receiveValue: { value in
                subject.send(value)
            }
    }

    func bindError<Subject>(to subject: Subject) -> AnyPublisher<Output, Failure> where Subject: Combine.Subject, Subject.Output: Error {
        return receive(on: RunLoop.main)
            .receiveCompletion { completion in
                if case .failure(let error) = completion,
                   let output = error as? Subject.Output {
                    subject.send(output)
                }
            }
    }
}

// Async/await

enum AsyncError: Error {
    case finishedWithoutValue
}

public extension Publisher {
    // for throwing Combine pipeline and a non-throwing Combine pipeline
    func `await`<T>(_ transform: @escaping (Output) async throws -> T) ->
    Publishers.FlatMap<Future<T, Error>, Publishers.SetFailureType<Publishers.HandleEvents<Self>, Error>> {
        var task: Task<(), Error>?

        return handleEvents(receiveCancel: { // swiftlint:disable:this trailing_closure
            task?.cancel()
        })
        .flatMap { value -> Future<T, Error> in
            Future { promise in
                task = Task {
                    do {
                        let result = try await transform(value)
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }

    func async(_ action: @escaping (Output) async -> Void) -> AnyCancellable {
        receiveValue { value in
            Task {
                await action(value)
            }
        }
    }

    func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            var finishedWithoutValue = true
            cancellable =
            first() // swiftlint:disable:this trailing_closure
                .handleEvents(
                    receiveCancel: {
                        continuation.resume(throwing: AsyncError.finishedWithoutValue)
                    }
                )
                .sink { result in
                    switch result {
                    case .finished:
                        if finishedWithoutValue {
                            continuation.resume(throwing: AsyncError.finishedWithoutValue)
                        }
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel()
                } receiveValue: { value in
                    finishedWithoutValue = false
                    continuation.resume(with: .success(value))
                }
        }
    }

    //    func asyncStream() -> CombineAsyncStream<Self> {
    //        return CombineAsyncStream(self)
    //    }

    //    func asyncStream() -> AsyncThrowingStream<Output, Error> {
    //        return AsyncThrowingStream { continuation in
    //            var cancellable: AnyCancellable?
    //            cancellable = handleEvents(
    //                receiveCancel: {
    //                    continuation.finish()
    //                }
    //            )
    //            .sink { result in
    //                switch result {
    //                case .finished:
    //                    break
    //                case let .failure(error):
    //                    dLog("+++ \(error)")
    //                    continuation.finish(throwing: error)
    //                }
    //                cancellable?.cancel()
    //                continuation.finish()
    //            } receiveValue: { value in
    //                continuation.yield(value)
    //            }
    //        }
    //    }
}

//public class CombineAsyncStream<Upstream: Publisher>: AsyncSequence {
//    public typealias Element = Upstream.Output
//    public typealias AsyncIterator = CombineAsyncStream<Upstream>
//
//    public func makeAsyncIterator() -> Self {
//        return self
//    }
//
//    private let stream: AsyncThrowingStream<Element, Error>
//
//    private lazy var iterator = stream.makeAsyncIterator()
//
//    private var cancellable: AnyCancellable?
//    public init(_ upstream: Upstream) {
//        var subscription: AnyCancellable?
//
//        stream = AsyncThrowingStream<Element, Error> { continuation in
//            subscription = upstream
//                .handleEvents(
//                    receiveCancel: {
//                        continuation.finish()
//                    }
//                )
//                .sink(receiveCompletion: { completion in
//                    switch completion {
//                    case .failure(let error):
//                        continuation.finish(throwing: error)
//                    case .finished:
//                        continuation.finish()
//                    }
//                }, receiveValue: { value in
//                    continuation.yield(value)
//                })
//        }
//
//        cancellable = subscription
//    }
//
//    public func cancel() {
//        cancellable?.cancel()
//        cancellable = nil
//    }
//}
//
//extension CombineAsyncStream: AsyncIteratorProtocol {
//    public func next() async throws -> Upstream.Output? {
//        return try await iterator.next()
//    }
//}
