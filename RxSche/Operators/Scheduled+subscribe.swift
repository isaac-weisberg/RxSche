import RxSwift

public extension ScheduledObservableType {
    func subscribe(onNext: ((Element) -> Void)? = nil, onError: ((Swift.Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil) -> Disposable {
        return source.subscribe(onNext: { element, _ in
            onNext?(element)
        }, onError: onError, onCompleted: onCompleted, onDisposed: onDisposed)
    }

    func subscribe<O: ScheduledObserverType>(to observer: O) -> Disposable
        where O.Element == Element, O.Scheduling == Scheduling {

        return source.subscribe(onNext: { [onNext = observer.onNext] element, scheduler in
            onNext?((element, scheduler))
        }, onError: observer.onError, onCompleted: observer.onCompleted)
    }
}
