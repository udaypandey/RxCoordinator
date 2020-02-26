//
//  RegistrationCoordinator.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension RegistrationCoordinator {
    enum Event {
        case initial
        case didFinishFirstName(_ firstName: String)
        case didFinishEmail
    }
}

class RegistrationCoordinator: CoordinatorType {
    private let context: UINavigationController
    weak var parentCoordinator: OnboardingCoordinator?

    private var model: Model?

    private let firstNameCoordinator: FirstNameCoordinator
    private let emailCoordinator: EmailCoordinator

    init(context: UINavigationController) {
        self.context = context

        firstNameCoordinator = FirstNameCoordinator(context: context)
        emailCoordinator = EmailCoordinator(context: context)

        firstNameCoordinator.parentCoordinator = self
        emailCoordinator.parentCoordinator = self
    }

    func start() {
        print("\(type(of: self)): start")
        loop(event: .initial)
    }

    func loop(event: Event) {
        print("\(type(of: self)): fsm: \(event)")

        let newEvent = fsm(event: event)
        switch newEvent {
        case .initial:
            firstNameCoordinator.start()

        case .didFinishFirstName(let firstName):
            model = Model(firstName: firstName)
            emailCoordinator.start(model: model!)

        case .didFinishEmail:
            parentCoordinator?.loop(event: .didFinishRegistration)
            break
        }
    }
}

extension RegistrationCoordinator {
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
        print("\(type(of: self)): fsm: \(event)")

        return event
    }
}

extension RegistrationCoordinator: ReactiveCompatible {}
extension Reactive where Base: RegistrationCoordinator {
    var fsm: Binder<RegistrationCoordinator.Event> {
        return Binder(self.base) { c, event in
            c.loop(event: event)
        }
    }
}
