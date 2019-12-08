import RxSwift
import RxCocoa

public protocol ScheduledObserverType {
    associatedtype Element
    associatedtype Scheduling: SchedulingType

    var onNext: ((Element) -> Void)? { get }
    var onError: ((Swift.Error) -> Void)? { get }
    var onCompleted: (() -> Void)? { get }
}

public struct ScheduledObserver<Element, Scheduling: SchedulingType>: ScheduledObserverType {
    public let onNext: ((Element) -> Void)?
    public let onError: ((Error) -> Void)?
    public let onCompleted: (() -> Void)?

    public init(onNext: ((Element) -> Void)? = nil, onError: ((Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil) {
        self.onNext = onNext
        self.onError = onError
        self.onCompleted = onCompleted
    }

    public init(binder: Binder<Element>) {
        self.onNext = binder.onNext
        self.onError = nil
        self.onCompleted = nil
    }
}
