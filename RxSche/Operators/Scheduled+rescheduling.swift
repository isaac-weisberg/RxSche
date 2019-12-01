import RxSwift

public extension ScheduledSequence {
    func observeOn<Scheduler: RxSchedulerType>(_ scheduler: Scheduler)
        -> ScheduledSequence<Element, Scheduler> {

        return ScheduledSequence<Element, Scheduler>(raw: source.observeOn(scheduler), scheduler)
    }

    func subscribeOn<Scheduler: RxSchedulerType>(_ scheduler: Scheduler)
        -> ScheduledSequence<Element, Scheduling>
        where Scheduling: UndefinedSchedulingType {

        return ScheduledSequence(raw: source.subscribeOn(scheduler), self.scheduling)
    }

    func subscribeOn<Scheduler: RxSchedulerType>(_ scheduler: Scheduler)
        -> ScheduledSequence<Element, Scheduler>
        where Scheduling: DefinedSchedulingType {

        return ScheduledSequence<Element, Scheduler>(raw: source.subscribeOn(scheduler), scheduler)
    }
}
