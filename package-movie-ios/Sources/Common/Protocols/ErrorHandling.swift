//
//  ErrorHandling.swift
//  
//
//  Created by Luu Phan on 16/02/2023.
//

import Foundation
import Domain
import Combine

private var errorTypeKey = ""

private class ErrorType {
    @Atomic var list = [String: Bool]()
    
    func append(_ errorType: String) {
        list[errorType] = true
    }
}

public protocol ErrorHandling: AnyObject {
    
    var errorSubject: PassthroughSubject<Error, Never> { get set }
    var cancellables: Set<AnyCancellable> { get set }
    
    func receiveError<E: Error>(_ type: E.Type) -> AnyPublisher<E, Never>
    func send(error: Error)
    func bind<Subject>(errorTo subject: Subject, autoCancel: Bool)
            where Subject: Combine.Subject, Subject.Output == Error, Subject.Failure == Never
}

public extension ErrorHandling {
    private var errorType: ErrorType {
        get {
            guard let obj = objc_getAssociatedObject(self, &errorTypeKey) as? ErrorType else {
                let obj = ErrorType()
                self.errorType = obj
                return obj
            }

            return obj
        }
        set {
            objc_setAssociatedObject(self, &self.errorType, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func receiveError<E: Error>(_ type: E.Type = Error.self) -> AnyPublisher<E, Never> {
        guard type.self != ErrorType.self else {
            return errorSubject
                .share()
                .delay(for: 0.1, scheduler: RunLoop.current)
                .filter { [weak self] in
                    guard let self else { return false }
                    return self.errorType.list["\($0.self)"] != true
                }
                .compactMap { $0 as? E }
                .eraseToAnyPublisher()
        }
        return errorSubject
            .share()
            .compactMap { $0 as? E }
            .receiveValue { [weak self] in self?.errorType.append("\( $0.self )") }
            .eraseToAnyPublisher()
    }
    
    func send(error: Error) {
        errorSubject.send(error)
    }
    
    func bind<Subject>(errorTo subject: Subject, autoCancel: Bool = false) where Subject: Combine.Subject, Subject.Output == Error, Subject.Failure == Never {
        errorSubject
            .share()
            .bind(to: subject, autoCancel: autoCancel)
            .store(in: &cancellables)
    }
    
}

public final class ErrorHandler<Owner>: ObservableObject, ErrorHandling {
    
    public var cancellables = Set<AnyCancellable>()
    public var errorSubject = PassthroughSubject<Error, Never>()

    deinit {
         dLog("++++ \(self) deinit")
    }

    public init() {}
}
