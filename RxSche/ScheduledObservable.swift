import RxSwift

public protocol ScheduledObservableType {
    associatedtype Element
    associatedtype Scheduling: SchedulingType

    var source: Observable<(Element, Scheduling)> { get }
}

public struct ScheduledObservable<Element, Scheduling: SchedulingType>: ScheduledObservableType {
    public let source: Observable<(Element, Scheduling)>

    init(raw: Observable<(Element, Scheduling)>) {
        self.source = raw
    }
}
