import RxSwift

public class ScheduledPublishSubject<Element, Scheduling: SchedulingType>: ScheduledObservableType {
    public let source: Observable<(Element, Scheduling)>

    let subject = PublishSubject<(Element, Scheduling)>()

    public init() {
        source = subject.asObservable()
    }
}
