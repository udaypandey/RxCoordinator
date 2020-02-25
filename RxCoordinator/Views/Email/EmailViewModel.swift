//
//  EmailViewModel.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct EmailViewModel: ViewModelType {
    let inputs: Inputs
    let outputs: Outputs
    let flows: Flows

    init(model: Model) {
        let continueButton = PublishSubject<Void>()
        let email = BehaviorSubject<String>(value: "Robert")

        self.inputs = Inputs(continueTappedObserver: continueButton.asObserver())

        let emailDriver = email.asDriver(onErrorJustReturn: "")
        self.outputs = Outputs(email: emailDriver)

        let didFinishEmail = continueButton
            .withLatestFrom(email)
            .flatMap({ email in
                // Make network call to register user
                // On success, flip to next screen
                model.addUser(firstName: model.firstName, email: email)
            })
            .filter { $0 }
            .map { _ in Event.didFinishEmail }

        self.flows = Flows(didFinishEmail: didFinishEmail)
    }
}

extension EmailViewModel {
    struct Inputs {
        let continueTappedObserver: AnyObserver<Void>
    }

    struct Flows {
        let didFinishEmail: Observable<Event>
    }

    struct Outputs {
        let email: Driver<String>
    }

    enum Event {
        case didFinishEmail
    }
}


