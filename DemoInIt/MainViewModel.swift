import RxSwift
import RxSche

protocol MainViewModelProtocol {
    var titleText: ScheduledObservable<String?, MainScheduler> { get }

    var reloadTap: ScheduledPublishSubject<Void, MainScheduler> { get }
}

class MainViewModel: MainViewModelProtocol {
    let titleText: ScheduledObservable<String?, MainScheduler>
    let reloadTap = ScheduledPublishSubject<Void, MainScheduler>()

    init() {
        titleText = reloadTap
            .observeOn(ConcurrentDispatchQueueScheduler(queue: .global()))
            .map { _ in
                [
                    "Who are you?",
                    "What are you doing?",
                    "Stop it!",
                ].randomElement()!
            }
            .observeOn(MainScheduler.instance)
    }
}
