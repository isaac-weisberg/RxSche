import RxSwift

public extension ObservableType {
    func scheduledObserveOn<Scheduler: RxSchedulerType>(_ scheduler: Scheduler)
        -> ScheduledObservable<Element, Scheduler> {

        return ScheduledObservable(raw: observeOn(scheduler))
    }
}
