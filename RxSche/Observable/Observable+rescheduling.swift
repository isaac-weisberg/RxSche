import RxSwift

public extension ObservableType {
    func scheduledObserveOn<Scheduler: RxSchedulerType>(_ scheduler: Scheduler)
        -> ScheduledSequence<Element, Scheduler> {

        return ScheduledSequence(raw: observeOn(scheduler)
            .map { element in
                (element, scheduler)
            })
    }
}
