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

    func flatMap<Result, Scheduling: DefinedSchedulingType>(_ selector: @escaping (Element) -> ScheduledSequence<Result, Scheduling>)
        -> ScheduledSequence<Result, Scheduling> {

        let resultSequence: Observable<(Result, Scheduling)> = source.flatMap { args -> Observable<(Result, Scheduling)> in
            let (element, _) = args
            return Observable.just(element)
                .flatMap { element -> Observable<(Result, Scheduling)> in
                    let resultSequence = selector(element)
                    return resultSequence.source
                }
        }

        return ScheduledSequence<Result, Scheduling>(raw: resultSequence)
    }
}


func a() {
//    let obs = Observable<Void>.just(())
//    .flatMap(<#T##selector: (()) throws -> ObservableConvertibleType##(()) throws -> ObservableConvertibleType#>)
}
