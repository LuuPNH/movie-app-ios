import Foundation
import Domain

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
    var errorHandler: ErrorHandler<Self> {
        get {
            guard let obj = objc_getAssociatedObject(self, &errorHandlerKey) as? ErrorHandler<Self> else {
                let obj = ErrorHandler<Self>()
                self.errorHandler = obj
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
                obj.catchError(in: errorHandler)
                    
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
                obj.catchError(in: errorHandler)
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
