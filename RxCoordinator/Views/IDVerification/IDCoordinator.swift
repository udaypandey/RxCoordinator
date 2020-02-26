//
//  IDCoordinator.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class IDCoordinator: CoordinatorType {
    private let disposeBag = DisposeBag()
    private var context: UINavigationController
    weak var parentCoordinator: IDVerificationCoordinator?

    init(context: UINavigationController) {
        self.context = context
    }

    func loop(event: IDViewModel.Event) {
        // Delegate to Flow coordinator
        switch event {
        case .didFinishID:
            parentCoordinator?.loop(event: .didSubmitVerification)
        }
    }

    func start() {
        print("\(type(of: self)): start")

        let viewModel = IDViewModel()

        let viewController = IDViewController(nibName: nil, bundle: nil)
        viewController.viewModel = viewModel

        // Bind to VM.Flows
        viewModel.flows.didFinishID
            .bind(to: self.rx.fsm)
            .disposed(by: disposeBag)

        context.pushViewController(viewController, animated: true)
    }
}

extension IDCoordinator: ReactiveCompatible {}
extension Reactive where Base: IDCoordinator {
    var fsm: Binder<IDViewModel.Event> {
        return Binder(self.base) { c, event in
            c.loop(event: event)
        }
    }
}
