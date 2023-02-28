//
//  ViewModel.swift
//  
//
//  Created by Luu Phan on 16/02/2023.
//

import Foundation

public protocol ViewModel: ObservableObject {
    associatedtype Action = Never
    
    func dispatch(action: Action)
}

public extension ViewModel where Action == Never {
    func dispatch(action: Action) {}
}

private var errorHandlerKey = ""
private var asyncTaskKey = ""
private var publishTaskKey = ""

public extension ViewModel {
    
    var errorHandle: ErrorHandler<Self> {
        get {
            guard let obj = objc_getAssociatedObject(self, &errorHandlerKey) as? ErrorHandler<Self> else {
                let obj = ErrorHandler<Self>()
                self.errorHandle = obj
                return obj
            }
            return obj
        }
        set {
            objc_setAssociatedObject(self, &errorHandlerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var asyncTask: AsyncTask {
        get {
            guard let obj = objc_getAssociatedObject(self, &asyncTaskKey) as? AsyncTask else {
                let obj = AsyncTask()
                self.asyncTask = obj
                return obj
            }
            return obj
        }
        set {
            objc_setAssociatedObject(self, &asyncTaskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var publishTask: PublishTask {
        get {
            guard let obj = objc_getAssociatedObject(self, &publishTaskKey) as? PublishTask else {
                let obj = PublishTask()
                self.publishTask = obj
                return obj
            }
            return obj
        }
        set {
            objc_setAssociatedObject(self, &publishTaskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

