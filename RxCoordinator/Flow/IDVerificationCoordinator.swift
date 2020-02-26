//
//  IDVerificationCoordinator.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 26/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension IDVerificationCoordinator {
    enum Event {
        case initial
        case didSubmitVerification
    }
}

class IDVerificationCoordinator: CoordinatorType {
    private let context: UINavigationController
    weak var parentCoordinator: OnboardingCoordinator?

    private let firstNameCoordinator: FirstNameCoordinator
    private let emailCoordinator: EmailCoordinator

    init(context: UINavigationController) {
        self.context = context

        firstNameCoordinator = FirstNameCoordinator(context: context)
        emailCoordinator = EmailCoordinator(context: context)
    }

    func start() {
        print("\(type(of: self)): start")
        loop(event: .initial)
    }

    func loop(event: Event) {
        print("\(type(of: self)): loop: \(event)")

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

        case .didSubmitVerification:
            break
        }
    }
}

extension IDVerificationCoordinator: ReactiveCompatible {}
extension Reactive where Base: IDVerificationCoordinator {
    var fsm: Binder<IDVerificationCoordinator.Event> {
        return Binder(self.base) { c, event in
            c.loop(event: event)
        }
    }
}
