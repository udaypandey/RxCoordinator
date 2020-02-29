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
        case didFinishRegistration(_ model: Model)
        case didFinishPhoneValidation
        case didFinishVerification
    }
}

class OnboardingCoordinator: CoordinatorType {
    private let context: UINavigationController
    private var model: Model?
    private var childCoordinator: AnyObject? = nil

    init(context: UINavigationController) {
        self.context = context
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
            let coordinator = RegistrationCoordinator(context: context, parent: self)
            childCoordinator = coordinator
            coordinator.start()

        case .didFinishRegistration(let model):
            self.model = model
            let coordinator = PhoneValidationCoordinator(context: context, model: model, parent: self)
            childCoordinator = coordinator
            coordinator.start()

        case .didFinishPhoneValidation:
            let coordinator = IDVerificationCoordinator(context: context, model: model!, parent: self)
            childCoordinator = coordinator
            coordinator.start()

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
