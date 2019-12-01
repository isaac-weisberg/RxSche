import RxSwift

public extension ScheduledSequence {
    func observeOn<Scheduler: RxSchedulerType>(_ scheduler: Scheduler)
        -> ScheduledSequence<Element, Scheduler> {

        return ScheduledSequence<Element, Scheduler>(raw: source.observeOn(scheduler).map { element, _ in
            (element, scheduler)
        })
    }

    func subscribeOn<Scheduler: RxSchedulerType>(_ scheduler: Scheduler)
        -> ScheduledSequence<Element, Scheduling>
        where Scheduling: AsyncScheduling {

        return ScheduledSequence<Element, Scheduling>(raw: source.subscribeOn(scheduler))
    }

    func subscribeOn<Scheduler: RxSchedulerType>(_ scheduler: Scheduler)
        -> ScheduledSequence<Element, Scheduler>
        where Scheduling: SyncScheduling {

        return ScheduledSequence<Element, Scheduler>(raw: source.subscribeOn(scheduler)
            .map { element, _ in
                (element, scheduler)
            })
    }
}
