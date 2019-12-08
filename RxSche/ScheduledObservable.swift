import RxSwift

public protocol ScheduledObservableType {
    associatedtype Element
    associatedtype Scheduling: SchedulingType

    var source: Observable<Element> { get }
}

public struct ScheduledObservable<Element, Scheduling: SchedulingType>: ScheduledObservableType {
    public let source: Observable<Element>

    init(raw: Observable<Element>) {
        self.source = raw
    }
}
