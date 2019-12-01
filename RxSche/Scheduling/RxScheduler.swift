import RxSwift

public protocol RxSchedulerType: SchedulerType, SchedulingType {

}

// extension MainScheduler: RxSchedulerType { } // huh?

extension ConcurrentMainScheduler: RxSchedulerType, AsyncScheduling { }

extension SerialDispatchQueueScheduler: RxSchedulerType, AsyncScheduling { }

extension ConcurrentDispatchQueueScheduler: RxSchedulerType, AsyncScheduling { }

extension CurrentThreadScheduler: SchedulingType, SyncScheduling { }
