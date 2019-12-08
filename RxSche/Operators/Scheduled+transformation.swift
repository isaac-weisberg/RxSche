import RxSwift

public extension ScheduledObservableType {
    func map<Result>(_ transform: @escaping (Element) throws -> Result) -> ScheduledObservable<Result, Scheduling> {
        let target = source.map(transform)

        return ScheduledObservable<Result, Scheduling>(raw: target)
    }

    func filter(_ predicate: @escaping (Element) throws -> Bool) -> ScheduledObservable<Element, Scheduling> {
        return ScheduledObservable(raw: source.filter(predicate))
    }

    func flatMap<Result, Scheduler: AsyncScheduling>(_ selector: @escaping (Element) -> ScheduledObservable<Result, Scheduler>)
        -> ScheduledObservable<Result, Scheduler> {

        let resultSequence = source
            .flatMap { element -> Observable<Result> in
                selector(element).source
            }

        return ScheduledObservable<Result, Scheduler>(raw: resultSequence)
    }

    func flatMap<Result, Scheduler: SyncScheduling>(_ selector: @escaping (Element) -> ScheduledObservable<Result, Scheduler>)
        -> ScheduledObservable<Result, Scheduling> {

        let resultSequence = source
            .flatMap { element -> Observable<Result> in
                selector(element).source
            }

        return ScheduledObservable<Result, Scheduling>(raw: resultSequence)
    }

    func flatMapLatest<Result, Scheduler: AsyncScheduling>(_ selector: @escaping (Element) -> ScheduledObservable<Result, Scheduler>)
        -> ScheduledObservable<Result, Scheduler> {

            let resultSequence = source
                .flatMap { element in
                    selector(element).source
                }

            return ScheduledObservable<Result, Scheduler>(raw: resultSequence)
    }

    func flatMapLatest<Result, Scheduler: SyncScheduling>(_ selector: @escaping (Element) -> ScheduledObservable<Result, Scheduler>)
        -> ScheduledObservable<Result, Scheduling> {

            let resultSequence = source
                .flatMap { element in
                    selector(element).source
            }

            return ScheduledObservable<Result, Scheduling>(raw: resultSequence)
    }
}
