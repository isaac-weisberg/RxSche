import RxSwift
import RxCocoa

public protocol ScheduledObserverType {
    associatedtype Element
    associatedtype Scheduling: SchedulingType

    var onNext: (((Element, Scheduling)) -> Void)? { get }
    var onError: ((Swift.Error) -> Void)? { get }
    var onCompleted: (() -> Void)? { get }
}

public struct ScheduledObserver<Element, Scheduling: SchedulingType>: ScheduledObserverType {
    public let onNext: (((Element, Scheduling)) -> Void)?
    public let onError: ((Error) -> Void)?
    public let onCompleted: (() -> Void)?

    public init(onNext: (((Element, Scheduling)) -> Void)? = nil, onError: ((Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil) {
        self.onNext = onNext
        self.onError = onError
        self.onCompleted = onCompleted
    }

    public init(binder: Binder<Element>) {
        self.onNext = { arg in
            let (element, _) = arg
            binder.onNext(element)
        }
        self.onError = nil
        self.onCompleted = nil
    }
}
