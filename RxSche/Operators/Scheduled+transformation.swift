import RxSwift

public extension ScheduledObservableType {
    func map<Result>(_ transform: @escaping (Element) throws -> Result) -> ScheduledObservable<Result, Scheduling> {
        let target = source.flatMap { element, scheduling in
            Observable.just(element)
                .map(transform)
                .map { result in
                    (result, scheduling)
                }
        }

        return ScheduledObservable<Result, Scheduling>(raw: target)
    }

    func filter(_ predicate: @escaping (Element) throws -> Bool) -> ScheduledObservable<Element, Scheduling> {
        return ScheduledObservable(raw: source.flatMap { element, scheduling in
            Observable.just(element)
                .filter(predicate)
                .map { result in
                    (result, scheduling)
                }
        })
    }

    func flatMap<Result, Scheduler: AsyncScheduling>(_ selector: @escaping (Element) -> ScheduledObservable<Result, Scheduler>)
        -> ScheduledObservable<Result, Scheduler> {

        let resultSequence: Observable<(Result, Scheduler)> = source.flatMap { element, _ -> Observable<(Result, Scheduler)> in
            Observable.just(element)
                .flatMap { element -> Observable<(Result, Scheduler)> in
                    let resultSequence = selector(element)
                    return resultSequence.source
                }
        }

        return ScheduledObservable<Result, Scheduler>(raw: resultSequence)
    }

    func flatMap<Result, Scheduler: SyncScheduling>(_ selector: @escaping (Element) -> ScheduledObservable<Result, Scheduler>)
        -> ScheduledObservable<Result, Scheduling> {

        let resultSequence = source
            .flatMap { element, originalScheduling -> Observable<(Result, Scheduling)> in
                Observable.just(element)
                    .flatMap { element -> Observable<(Result, Scheduling)> in
                        let resultSequence = selector(element)
                        return resultSequence.source
                            .map { element, _ in
                                (element, originalScheduling)
                            }
                    }
            }

        return ScheduledObservable<Result, Scheduling>(raw: resultSequence)
    }

    func flatMapLatest<Result, Scheduler: AsyncScheduling>(_ selector: @escaping (Element) -> ScheduledObservable<Result, Scheduler>)
        -> ScheduledObservable<Result, Scheduler> {

            let resultSequence: Observable<(Result, Scheduler)> = source.flatMap { element, _ -> Observable<(Result, Scheduler)> in
                Observable.just(element)
                    .flatMapLatest { element -> Observable<(Result, Scheduler)> in
                        let resultSequence = selector(element)
                        return resultSequence.source
                }
            }

            return ScheduledObservable<Result, Scheduler>(raw: resultSequence)
    }

    func flatMapLatest<Result, Scheduler: SyncScheduling>(_ selector: @escaping (Element) -> ScheduledObservable<Result, Scheduler>)
        -> ScheduledObservable<Result, Scheduling> {

            let resultSequence = source
                .flatMapLatest { element, originalScheduling -> Observable<(Result, Scheduling)> in
                    Observable.just(element)
                        .flatMap { element -> Observable<(Result, Scheduling)> in
                            let resultSequence = selector(element)
                            return resultSequence.source
                                .map { element, _ in
                                    (element, originalScheduling)
                            }
                    }
            }

            return ScheduledObservable<Result, Scheduling>(raw: resultSequence)
    }
}
