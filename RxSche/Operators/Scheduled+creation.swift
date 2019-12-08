import RxSwift

public extension Scheduled {
    static func just<Element>(_ element: Element)
        -> ScheduledObservable<Element, CurrentThreadScheduler> {
            
        return ScheduledObservable(raw: Observable.just(element))
    }
}
