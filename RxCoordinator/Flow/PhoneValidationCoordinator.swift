//
//  OTPCoordinator.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 26/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension PhoneValidationCoordinator {
    enum Event {
        case initial
        case didFinishPhone
        case didFinishOTP
    }
}

class PhoneValidationCoordinator: ChildCoordinatorType {
    private let context: UINavigationController
    weak var parent: OnboardingCoordinator?
    let model: Model
    let disposeBag = DisposeBag()

    init(context: UINavigationController, model: Model, parent: OnboardingCoordinator?) {
        self.model = model
        self.context = context
        self.parent = parent
    }

    func start() {
        indentPrint(1, "\(type(of: self)): start")
        loop(event: .initial)
    }

    fileprivate func loop(event: Event) {
        indentPrint(1, "\(type(of: self)): loop: \(event)")

        let newEvent = fsm(event: event)
        switch newEvent {
        case .initial:
            PhoneFactory.start(context: context, model: model, coordinator: self)

        case .didFinishPhone:
            OTPFactory.start(context: context, model: model, coordinator: self)

        case .didFinishOTP:
            parent?.loop(event: .didFinishPhoneValidation)
        }
    }
}

extension PhoneValidationCoordinator {
    // This is the brain of the coordinator and for the spike
    // this does not do anything and returns the same event back

    // MARK: TODO: Ideally there should a state and an event
    // for FSM to run correctly. This is just a sample
    // implementation and accepts all incoming events even
    // if its not in the right state.

    // Will move the FSM object on its own, this is just a
    // placeholder. It will be injected or created as part
    // of init and used to drive based on incoming events.
    func fsm(event: Event) -> Event {
        return event
    }
}

extension PhoneValidationCoordinator: ReactiveCompatible {}
extension Reactive where Base: PhoneValidationCoordinator {
    var fsm: Binder<PhoneValidationCoordinator.Event> {
        return Binder(self.base) { c, event in
            c.loop(event: event)
        }
    }
}
