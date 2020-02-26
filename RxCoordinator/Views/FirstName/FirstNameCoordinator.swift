//
//  FirstNameCoordinator.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class FirstNameCoordinator: CoordinatorType {
    private let disposeBag = DisposeBag()
    private var context: UINavigationController

    init(context: UINavigationController) {
        self.context = context
    }

    func loop(event: FirstNameViewModel.Event) {
        // Delegate to Flow coordinator
    }

    func start() {
        print("FirstNameCoordinator: start")

        let viewModel = FirstNameViewModel()

        let viewController = FirstNameViewController(nibName: nil, bundle: nil)
        viewController.viewModel = viewModel

        // Bind to VM.Flows
        viewModel.flows.didFinishFirstName
            .bind(to: self.rx.fsm)
            .disposed(by: disposeBag)

        context.pushViewController(viewController, animated: true)
    }
}

extension FirstNameCoordinator: ReactiveCompatible {}
extension Reactive where Base: FirstNameCoordinator {
    var fsm: Binder<FirstNameViewModel.Event> {
        return Binder(self.base) { c, event in
            c.loop(event: event)
        }
    }
}
