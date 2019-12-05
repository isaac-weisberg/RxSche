import RxSwift

public class ScheduledPublishSubject<Element, Scheduling: SchedulingType>: ScheduledObservableType, ScheduledObserverType {
    public let onNext: (((Element, Scheduling)) -> Void)?
    public let onError: ((Error) -> Void)?
    public let onCompleted: (() -> Void)?
    public let source: Observable<(Element, Scheduling)>

    let subject: PublishSubject<(Element, Scheduling)>

    public init() {
        let subject = PublishSubject<(Element, Scheduling)>()
        self.subject = subject
        source = subject.asObservable()
        onNext = subject.onNext
        onError = subject.onError
        onCompleted = subject.onCompleted
    }
}
