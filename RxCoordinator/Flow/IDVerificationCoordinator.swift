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

    private let idVerifiyCoordinator: IDCoordinator

    init(context: UINavigationController) {
        self.context = context

        idVerifiyCoordinator = IDCoordinator(context: context)
        idVerifiyCoordinator.parentCoordinator = self
    }

    func start() {
        indentPrint(1, "\(type(of: self)): start")
        loop(event: .initial)
    }

    func loop(event: Event) {
        indentPrint(1, "\(type(of: self)): loop: \(event)")

        let newEvent = fsm(event: event)
        switch newEvent {
        case .initial:
            idVerifiyCoordinator.start()

        case .didSubmitVerification:
            break
        }
    }
}

extension IDVerificationCoordinator {
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

extension IDVerificationCoordinator: ReactiveCompatible {}
extension Reactive where Base: IDVerificationCoordinator {
    var fsm: Binder<IDVerificationCoordinator.Event> {
        return Binder(self.base) { c, event in
            c.loop(event: event)
        }
    }
}
