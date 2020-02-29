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

class RegistrationCoordinator: ChildCoordinatorType {
    let context: UINavigationController
    weak var parent: OnboardingCoordinator?
    let disposeBag = DisposeBag()
    private var model: Model?

    init(context: UINavigationController, parent: OnboardingCoordinator?) {
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
            FirstNameFactory.start(context: context, coordinator: self)

        case .didFinishFirstName(let firstName):
            model = Model(firstName: firstName)
            EmailFactory.start(context: context, model: model!, coordinator: self)

        case .didFinishEmail:
            parent?.loop(event: .didFinishRegistration(model!))
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
