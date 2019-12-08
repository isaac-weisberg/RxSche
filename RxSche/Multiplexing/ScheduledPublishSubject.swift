import RxSwift

public class ScheduledPublishSubject<Element, Scheduling: SchedulingType>: ScheduledObservableType, ScheduledObserverType {
    public let onNext: ((Element) -> Void)?
    public let onError: ((Error) -> Void)?
    public let onCompleted: (() -> Void)?
    public let source: Observable<Element>

    let subject: PublishSubject<Element>

    public init() {
        let subject = PublishSubject<Element>()
        self.subject = subject
        source = subject.asObservable()
        onNext = subject.onNext
        onError = subject.onError
        onCompleted = subject.onCompleted
    }
}
