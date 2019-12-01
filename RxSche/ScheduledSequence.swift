import RxSwift

public struct ScheduledSequence<Element, Scheduling: SchedulingType> {
    let scheduling: Scheduling
    let source: Observable<Element>

    init(raw: Observable<Element>, _ scheduling: Scheduling) {
        self.source = raw
        self.scheduling = scheduling
    }
}
