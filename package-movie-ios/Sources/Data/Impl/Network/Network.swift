//
//  Network.swift
//  SmartManager
//
//  Created by Phat Le on 01/11/2021.
//

import Foundation
import Combine
import Moya
import CombineMoya
import Domain
import Alamofire

typealias APIError = MoyaError

protocol Networking {
    func request<D: Codable>(targetType: TargetType) -> AnyPublisher<D, APIError>
    func requestVoid(targetType: TargetType) -> AnyPublisher<Void, APIError>
    func request<D: Codable>(targetType: TargetType) async throws -> D
    func request(targetType: TargetType) async throws
}

// swiftlint:disable colon
struct Network: Networking {
    fileprivate let provider: MoyaProvider<MultiTarget>

    init(
        endpointClosure : @escaping MoyaProvider<MultiTarget>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
        requestClosure  : @escaping MoyaProvider<MultiTarget>.RequestClosure  = MoyaProvider<MultiTarget>.defaultRequestMapping,
        stubClosure     : @escaping MoyaProvider<MultiTarget>.StubClosure     = MoyaProvider.neverStub,
        session         : Session                                             = MoyaProvider<MultiTarget>.defaultAlamofireSession(),
        plugins         : [PluginType]                                        = [MoyaProvider<MultiTarget>.defaultNetworkLoggerPlugin()],
        trackInflights  : Bool                                                = false
    ) {
        //
        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubClosure,
                                     session: session,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
    }

    func request<D: Codable>(targetType: TargetType) -> AnyPublisher<D, APIError> {
        return provider.requestPublisher(MultiTarget(targetType))
            .map(D.self)
            .eraseToAnyPublisher()
    }

    func requestVoid(targetType: TargetType) -> AnyPublisher<Void, APIError> {
        return provider.requestPublisher(MultiTarget(targetType))
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    func request<D>(targetType: TargetType) async throws -> D where D: Decodable, D: Encodable {
        try await requestWithTaskCancellationHandler { continuation in
            provider.request(MultiTarget(targetType)) { result in
                _Concurrency.Task {
                    switch result {
                    case .success(let response):
                        do {
                            let obj = try response.map(D.self)
                            await continuation.resume(with: .success(obj))
                        } catch {
                            await continuation.resume(with: .failure(error))
                        }
                    case .failure(let moyaError):
                        await continuation.resume(with: .failure(moyaError))
                    }
                }
            }
        }
    }

    func request(targetType: TargetType) async throws {
        try await requestWithTaskCancellationHandler { continuation in
            provider.request(MultiTarget(targetType)) { result in
                _Concurrency.Task {
                    switch result {
                    case .success:
                        await continuation.resume(with: .success(()))
                    case .failure(let moyaError):
                        await continuation.resume(with: .failure(moyaError))
                    }
                }
            }
        }
    }
}
// swiftlint:enable colon

extension Network {
    private actor NetworkActor<T> {
        private var cancellable: Moya.Cancellable?
        private var continuation: CheckedContinuation<T, Error>?
        private var isCancelled = false

        deinit {
            dLog("++++ \(self) deinit")
        }

        init() {
            dLog("++++ \(self) init")
        }

        func execute(with continuation: CheckedContinuation<T, Error>, task: (NetworkActor<T>) -> Moya.Cancellable) {
            self.continuation = continuation
            self.cancellable = task(self)
        }

        func cancel(_ error: Error? = nil) {
            resume(with: .failure(CancellationError()))
        }

        func resume(with result: Result<T, Error>) {
            switch result {
            case .success(let value):
                continuation?.resume(with: .success(value))
            case .failure(let error):
                guard isCancelled == false else {
                    dLog("NetworkActor has been cancelled")
                    return
                }
                isCancelled = true

                cancellable?.cancel()
                continuation?.resume(with: .failure(error))
            }
        }
    }

    private func requestWithTaskCancellationHandler<T>(_ task: @escaping (NetworkActor<T>) -> Moya.Cancellable) async throws -> T {
        let actor = NetworkActor<T>()
        return try await withTaskCancellationHandler(operation: {
            try await withCheckedThrowingContinuation { continuation in
                _Concurrency.Task {
                    await actor.execute(with: continuation, task: task)
                }
            }
        }, onCancel: {
            _Concurrency.Task {
                print("TEQNetworkActor is cancelling")
                await actor.cancel()
            }
        })
    }
}

extension MoyaProvider {
    static func defaultNetworkLoggerPlugin() -> NetworkLoggerPlugin {
        NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: defaultJSONResponseDataFormatter),
                                                 logOptions: .verbose))
    }

    static func defaultJSONResponseDataFormatter(_ data: Data) -> String {
        data.jsonFormatter()
    }
}
