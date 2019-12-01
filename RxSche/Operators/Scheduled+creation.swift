import RxSwift

public extension Scheduled {
    static func just<Element>(_ element: Element)
        -> ScheduledSequence<Element, CurrentThreadScheduler> {
            
            return ScheduledSequence(raw: Observable.just(element), CurrentThreadScheduler.instance)
    }

    static func create<Element>(_ subscribe: @escaping (AnyObserver<Element>) -> Disposable)
        -> ScheduledSequence<Element, UndefinedScheduling> {

        return ScheduledSequence(raw: Observable.create(subscribe), UndefinedScheduling.instance)
    }
}
