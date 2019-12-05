import RxSwift
import RxCocoa
import UIKit

public extension Reactive where Base: UILabel {
    var scheduledText: ScheduledObserver<String?, MainScheduler> {
        return ScheduledObserver(binder: text)
    }
}
