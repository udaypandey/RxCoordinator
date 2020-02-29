//
//  OTPCoordinator.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class OTPCoordinator: CoordinatorType {
    private let disposeBag = DisposeBag()
    private var context: UINavigationController
    weak var parentCoordinator: PhoneValidationCoordinator?

    init(context: UINavigationController) {
        self.context = context
    }

    func loop(event: OTPViewModel.Event) {
        // Delegate to Flow coordinator
        switch event {
        case .didFinishOTP:
            parentCoordinator?.loop(event: .didValidateOTP)
        }
    }

    func start(model: Model) {
        indentPrint(2, "\(type(of: self)): start")

        let viewModel = OTPViewModel(model: model)

        let viewController = OTPViewController(nibName: nil, bundle: nil)
        viewController.viewModel = viewModel

        // Bind to VM.Flows
        viewModel.flows.didFinishOTP
            .bind(to: self.rx.fsm)
            .disposed(by: disposeBag)

        context.pushViewController(viewController, animated: true)
    }
}

extension OTPCoordinator: ReactiveCompatible {}
extension Reactive where Base: OTPCoordinator {
    var fsm: Binder<OTPViewModel.Event> {
        return Binder(self.base) { c, event in
            c.loop(event: event)
        }
    }
}
