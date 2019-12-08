import RxSwift

public extension ScheduledObservableType {
    func observeOn<Scheduler: RxSchedulerType>(_ scheduler: Scheduler)
        -> ScheduledObservable<Element, Scheduler> {

        return ScheduledObservable<Element, Scheduler>(raw: source.observeOn(scheduler))
    }

    func subscribeOn<Scheduler: RxSchedulerType>(_ scheduler: Scheduler)
        -> ScheduledObservable<Element, Scheduling>
        where Scheduling: AsyncScheduling {

        return ScheduledObservable<Element, Scheduling>(raw: source.subscribeOn(scheduler))
    }

    func subscribeOn<Scheduler: RxSchedulerType>(_ scheduler: Scheduler)
        -> ScheduledObservable<Element, Scheduler>
        where Scheduling: SyncScheduling {

        return ScheduledObservable<Element, Scheduler>(raw: source.subscribeOn(scheduler))
    }
}
