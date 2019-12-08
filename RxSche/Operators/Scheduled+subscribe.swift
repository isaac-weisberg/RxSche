import RxSwift

public extension ScheduledObservableType {
    func subscribe(onNext: ((Element) -> Void)? = nil, onError: ((Swift.Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil) -> Disposable {
        return source.subscribe(onNext: onNext, onError: onError, onCompleted: onCompleted, onDisposed: onDisposed)
    }

    func subscribe<O: ScheduledObserverType>(to observer: O) -> Disposable
        where O.Element == Element, O.Scheduling == Scheduling {

        return source.subscribe(onNext: observer.onNext, onError: observer.onError, onCompleted: observer.onCompleted)
    }
}
