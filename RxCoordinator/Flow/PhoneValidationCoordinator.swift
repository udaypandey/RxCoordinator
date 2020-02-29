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
        case didSubmitPhoneNumber
        case didValidateOTP
    }
}

class PhoneValidationCoordinator: CoordinatorType {
    private let context: UINavigationController
    weak var parentCoordinator: OnboardingCoordinator?

    var model: Model!

    private let phoneCoordinator: PhoneCoordinator
    private let otpCoordinator: OTPCoordinator

    init(context: UINavigationController) {
        self.context = context

        phoneCoordinator = PhoneCoordinator(context: context)
        otpCoordinator = OTPCoordinator(context: context)

        phoneCoordinator.parentCoordinator = self
        otpCoordinator.parentCoordinator = self
    }

    func start(model: Model) {
        indentPrint(1, "\(type(of: self)): start")
        self.model = model
        loop(event: .initial)
    }

    func loop(event: Event) {
        indentPrint(1, "\(type(of: self)): loop: \(event)")

        let newEvent = fsm(event: event)
        switch newEvent {
        case .initial:
            phoneCoordinator.start(model: model)

        case .didSubmitPhoneNumber:
            otpCoordinator.start(model: model)

        case .didValidateOTP:
            parentCoordinator?.loop(event: .didFinishPhoneValidation)
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
