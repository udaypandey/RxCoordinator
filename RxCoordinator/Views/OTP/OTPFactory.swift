//
//  OTPFactory.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 29/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class OTPFactory {
    static func start(context: UINavigationController, model: Model, coordinator: PhoneValidationCoordinator) {
        indentPrint(2, "\(type(of: self)): start")

        let viewModel = OTPViewModel(model: model)
        let viewController = OTPViewController(nibName: nil, bundle: nil)
        viewController.viewModel = viewModel

        // Bind to VM.Flows
        viewModel.flows.didFinishOTP
            .map(fsm)
            .bind(to: coordinator.rx.fsm)
            .disposed(by: coordinator.disposeBag)

        context.pushViewController(viewController, animated: true)
    }
}

extension OTPFactory {
    // This is the functor for transforming from view model agnostic
    // event to a particular Coordinator specific event.

    // This is in case we need to use the same screen and view model
    // with some other coordinator and one level of indirection
    // allows us to get there.

    // Seems like this is a simple transformation for most of the
    // screens and 1:1 too. So I think a pure transform function
    // is good enough for this.
    // In case the logic is more involved, we can use a FSM based
    // object that we may use for coordinators.
    static func fsm(event: OTPViewModel.Event) -> PhoneValidationCoordinator.Event {
        switch event {
        case .didFinishOTP:
            return .didFinishOTP
        }
    }
}
