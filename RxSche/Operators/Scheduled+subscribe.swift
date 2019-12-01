import RxSwift

public extension ScheduledSequence {
    func subscribe(onNext: ((Element) -> Void)? = nil, onError: ((Swift.Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil) -> Disposable {
        return source.subscribe(onNext: { element, _ in
            onNext?(element)
        }, onError: onError, onCompleted: onCompleted, onDisposed: onDisposed)
    }
}
