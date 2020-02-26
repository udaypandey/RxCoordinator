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

extension OTPCoordinator {
    enum Event {
        case initial
        case didFinishFirstName(_ firstName: String)
        case didFinishEmail
    }
}

class OTPCoordinator: CoordinatorType {
    func start() {
        print("RegistrationCoordinator: start")

        loop(event: .initial)
    }

    private let context: UINavigationController

    private var model: Model?

    private let firstNameCoordinator: FirstNameCoordinator
    private let emailCoordinator: EmailCoordinator

    init(context: UINavigationController) {
        self.context = context

        firstNameCoordinator = FirstNameCoordinator(context: context)
        emailCoordinator = EmailCoordinator(context: context)
    }

    func loop(event: Event) {
        print("RegistrationCoordinator: fsm: \(event)")

        // MARK: TODO: Ideally there should a state and an event
        // for FSM to run correctly. This is just a sample
        // implementation and accepts all incoming events even
        // if its not in the right state.

        // Will move the FSM object on its own, this is just a
        // placeholder. It will be injected or created as part
        // of init and used to drive based on incoming events.
        switch event {
        case .initial:
            firstNameCoordinator.start()

        case .didFinishFirstName(let firstName):
            model = Model(firstName: firstName)
            emailCoordinator.start(model: model!)

        case .didFinishEmail:
            break
        }
    }

}

extension OTPCoordinator: ReactiveCompatible {}
extension Reactive where Base: OTPCoordinator {
    var fsm: Binder<OTPCoordinator.Event> {
        return Binder(self.base) { c, event in
            c.loop(event: event)
        }
    }
}
