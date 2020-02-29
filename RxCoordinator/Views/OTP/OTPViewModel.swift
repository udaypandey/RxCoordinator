//
//  OTPViewModel.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct OTPViewModel: ViewModelType {
    let inputs: Inputs
    let outputs: Outputs
    let flows: Flows

    private let model: Model

    init(model: Model) {
        self.model = model

        let continueButton = PublishSubject<Void>()
        let otp = BehaviorSubject<String>(value: "123456")

        self.inputs = Inputs(continueTappedObserver: continueButton.asObserver())

        let otpDriver = otp.asDriver(onErrorJustReturn: "")
        self.outputs = Outputs(otp: otpDriver)

        let didFinishOTP = continueButton
            .withLatestFrom(otp)
            .flatMap({ otp in
                model.verifyOTP(otp: otp )
            })
            .filter { $0 }
            .map {_ in Event.didFinishOTP }

        self.flows = Flows(didFinishOTP: didFinishOTP)
    }
}

extension OTPViewModel {
    struct Inputs {
        let continueTappedObserver: AnyObserver<Void>
    }

    struct Outputs {
        let otp: Driver<String>
    }

    struct Flows {
        let didFinishOTP: Observable<Event>
    }

    enum Event {
        case didFinishOTP
    }
}
