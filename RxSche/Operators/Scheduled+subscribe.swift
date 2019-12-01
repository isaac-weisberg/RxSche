import RxSwift

public extension ScheduledSequence {
    func subscribe(onNext: ((Element) -> Void)? = nil, onError: ((Swift.Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil) -> Disposable {
        return source.subscribe(onNext: { element, _ in
            onNext?(element)
        }, onError: onError, onCompleted: onCompleted, onDisposed: onDisposed)
    }

    func subscribe(to observer: ScheduledObserver<Element, Scheduling>) -> Disposable {
        return source.subscribe(onNext: { [onNext = observer.onNext] element, _ in
            onNext?(element)
        }, onError: observer.onError, onCompleted: observer.onCompleted)
    }
}
