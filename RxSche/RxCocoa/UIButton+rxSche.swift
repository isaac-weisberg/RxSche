import UIKit
import RxCocoa
import RxSwift

public extension Reactive where Base: UIButton {
    var scheduledTap: ScheduledObservable<Void, MainScheduler> {
        return Scheduled.from(controlEvent: tap)
    }
}

extension Scheduled {
    static func from<Element>(controlEvent: ControlEvent<Element>) -> ScheduledObservable<Element, MainScheduler> {
        return ScheduledObservable(raw: controlEvent.asObservable())
    }
}
