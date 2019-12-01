import RxSwift

public extension Scheduled {
    static func just<Element>(_ element: Element)
        -> ScheduledSequence<Element, CurrentThreadScheduler> {
            
        return ScheduledSequence(raw: Observable.just((element, CurrentThreadScheduler.instance)))
    }
}
