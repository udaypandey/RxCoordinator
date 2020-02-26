//
//  PhoneViewModel.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct PhoneViewModel: ViewModelType {
    let inputs: Inputs
    let outputs: Outputs
    let flows: Flows

    init() {
        let continueButton = PublishSubject<Void>()
        let phone = BehaviorSubject<String>(value: "075813435")

        self.inputs = Inputs(continueTappedObserver: continueButton.asObserver())

        let phoneDriver = phone.asDriver(onErrorJustReturn: "")
        self.outputs = Outputs(phone: phoneDriver)

        let didFinishPhone = continueButton
            .withLatestFrom(phone)
            .map { Event.didFinishPhone($0) }

        self.flows = Flows(didFinishPhone: didFinishPhone)
    }
}

extension PhoneViewModel {
    struct Inputs {
        let continueTappedObserver: AnyObserver<Void>
    }

    struct Outputs {
        let phone: Driver<String>
    }

    struct Flows {
        let didFinishPhone: Observable<Event>
    }

    enum Event {
        case didFinishPhone(_ phone: String)
    }
}
