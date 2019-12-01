import RxSwift

public struct ScheduledSequence<Element, Scheduling: SchedulingType> {
    public let source: Observable<(Element, Scheduling)>

    init(raw: Observable<(Element, Scheduling)>) {
        self.source = raw
    }
}
