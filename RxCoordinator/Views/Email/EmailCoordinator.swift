//
//  EmailCoordinator.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class EmailCoordinator: CoordinatorType {
    private let disposeBag = DisposeBag()
    private var context: UINavigationController

    init(context: UINavigationController) {
        self.context = context
    }

    func fsm(event: EmailViewModel.Event) {
        // Delegate to Flow coordinator

    }

    func start(model: Model) {
        let viewModel = EmailViewModel(model: model)

        let viewController = EmailViewController(nibName: nil, bundle: nil)
        viewController.viewModel = viewModel

        // Bind to VM.Flows
        viewModel.flows.didFinishEmail
            .bind(to: self.rx.fsm)
            .disposed(by: disposeBag)

        context.pushViewController(viewController, animated: true)
    }
}

extension EmailCoordinator: ReactiveCompatible {}
extension Reactive where Base: EmailCoordinator {
    var fsm: Binder<EmailViewModel.Event> {
        return Binder(self.base) { c, event in
            c.fsm(event: event)
        }
    }
}
