//
//  OnboardingCoordinator.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 26/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension OnboardingCoordinator {
    enum Event {
        case initial
        case didFinishRegistration
        case didFinishPhoneValidation
        case didFinishVerification
    }
}

class OnboardingCoordinator: CoordinatorType {
    private let context: UINavigationController

    private var model: Model?

    // For simplicity and for the spike, I have created these upfront
    // Can create on the fly and let go when not needed in the real
    // implementation
    private let registrationCoordinator: RegistrationCoordinator
    private let phoneValidationCoordinator: PhoneValidationCoordinator
    private let idVerificationCoordinator: IDVerificationCoordinator

    init(context: UINavigationController) {
        self.context = context

        registrationCoordinator = RegistrationCoordinator(context: context)
        phoneValidationCoordinator = PhoneValidationCoordinator(context: context)
        idVerificationCoordinator = IDVerificationCoordinator(context: context)

        registrationCoordinator.parentCoordinator = self
        phoneValidationCoordinator.parentCoordinator = self
        idVerificationCoordinator.parentCoordinator = self
    }

    func start() {
        indentPrint(0, "\(type(of: self)): start")
        loop(event: .initial)
    }

    func loop(event: Event) {
        indentPrint(0, "\(type(of: self)): loop: \(event)")

        let newEvent = fsm(event: event)
        switch newEvent {
        case .initial:
            registrationCoordinator.start()

        case .didFinishRegistration:
            phoneValidationCoordinator.start()

        case .didFinishPhoneValidation:
            idVerificationCoordinator.start()

        case .didFinishVerification:
            break
        }
    }
}

extension OnboardingCoordinator {
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

extension OnboardingCoordinator: ReactiveCompatible {}
extension Reactive where Base: OnboardingCoordinator {
    var fsm: Binder<OnboardingCoordinator.Event> {
        return Binder(self.base) { c, event in
            c.loop(event: event)
        }
    }
}
