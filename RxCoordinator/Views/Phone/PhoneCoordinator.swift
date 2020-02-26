//
//  PhoneCoordinator.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class PhoneCoordinator: CoordinatorType {
    private let disposeBag = DisposeBag()
    private var context: UINavigationController
    weak var parentCoordinator: PhoneValidationCoordinator?

    init(context: UINavigationController) {
        self.context = context
    }

    func loop(event: PhoneViewModel.Event) {
        // Delegate to Flow coordinator
        switch event {
        case .didFinishPhone:
            parentCoordinator?.loop(event: .didSubmitPhoneNumber)
        }
    }

    func start() {
        print("\(type(of: self)): start")

        let viewModel = PhoneViewModel()

        let viewController = PhoneViewController(nibName: nil, bundle: nil)
        viewController.viewModel = viewModel

        // Bind to VM.Flows
        viewModel.flows.didFinishPhone
            .bind(to: self.rx.fsm)
            .disposed(by: disposeBag)

        context.pushViewController(viewController, animated: true)
    }
}

extension PhoneCoordinator: ReactiveCompatible {}
extension Reactive where Base: PhoneCoordinator {
    var fsm: Binder<PhoneViewModel.Event> {
        return Binder(self.base) { c, event in
            c.loop(event: event)
        }
    }
}
