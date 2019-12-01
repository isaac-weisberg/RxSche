import RxSwift

public extension ScheduledSequence {
    func map<Result>(_ transform: @escaping (Element) throws -> Result) -> ScheduledSequence<Result, Scheduling> {
        let target = source.flatMap { element, scheduling in
            Observable.just(element)
                .map(transform)
                .map { result in
                    (result, scheduling)
                }
        }

        return ScheduledSequence<Result, Scheduling>(raw: target)
    }

    func filter(_ predicate: @escaping (Element) throws -> Bool) -> ScheduledSequence<Element, Scheduling> {
        return ScheduledSequence(raw: source.flatMap { element, scheduling in
            Observable.just(element)
                .filter(predicate)
                .map { result in
                    (result, scheduling)
                }
        })
    }

    func flatMap<Result, Scheduler: AsyncScheduling>(_ selector: @escaping (Element) -> ScheduledSequence<Result, Scheduler>)
        -> ScheduledSequence<Result, Scheduler> {

        let resultSequence: Observable<(Result, Scheduler)> = source.flatMap { element, _ -> Observable<(Result, Scheduler)> in
            Observable.just(element)
                .flatMap { element -> Observable<(Result, Scheduler)> in
                    let resultSequence = selector(element)
                    return resultSequence.source
                }
        }

        return ScheduledSequence<Result, Scheduler>(raw: resultSequence)
    }

    func flatMap<Result, Scheduler: SyncScheduling>(_ selector: @escaping (Element) -> ScheduledSequence<Result, Scheduler>)
        -> ScheduledSequence<Result, Scheduling> {

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

        return ScheduledSequence<Result, Scheduling>(raw: resultSequence)
    }
}


func a() {
//    let obs = Observable<Void>.just(())
//    .flatMap(<#T##selector: (()) throws -> ObservableConvertibleType##(()) throws -> ObservableConvertibleType#>)
}
