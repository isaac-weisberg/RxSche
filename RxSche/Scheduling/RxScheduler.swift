import RxSwift

public protocol RxSchedulerType: SchedulerType, DefinedSchedulingType {

}

// extension MainScheduler: RxSchedulerType { } // huh?

extension ConcurrentMainScheduler: RxSchedulerType { }

extension SerialDispatchQueueScheduler: RxSchedulerType { }

extension ConcurrentDispatchQueueScheduler: RxSchedulerType { }

extension CurrentThreadScheduler: SchedulingType { }
