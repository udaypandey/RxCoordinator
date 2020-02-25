//
//  FirstNameViewModel.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct FirstNameViewModel: ViewModelType {
    let inputs: Inputs
    let outputs: Outputs
    let flows: Flows

    init() {
        let continueButton = PublishSubject<Void>()
        let firstName = BehaviorSubject<String>(value: "Robert")

        self.inputs = Inputs(continueTappedObserver: continueButton.asObserver())

        let firstNameDriver = firstName.asDriver(onErrorJustReturn: "")
        self.outputs = Outputs(firstName: firstNameDriver)

        let didFinishFirstName = continueButton
            .withLatestFrom(firstName)
            .map { Event.didFinishFirstName($0) }

        self.flows = Flows(didFinishFirstName: didFinishFirstName)
    }
}

extension FirstNameViewModel {
    struct Inputs {
        let continueTappedObserver: AnyObserver<Void>
    }

    struct Outputs {
        let firstName: Driver<String>
    }

    struct Flows {
        let didFinishFirstName: Observable<Event>
    }

    enum Event {
        case initial
        case didFinishFirstName(_ firstName: String)
    }
}
