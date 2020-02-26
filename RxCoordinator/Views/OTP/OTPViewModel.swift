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

    init() {
        let continueButton = PublishSubject<Void>()
        let otp = BehaviorSubject<String>(value: "123456")

        self.inputs = Inputs(continueTappedObserver: continueButton.asObserver())

        let otpDriver = otp.asDriver(onErrorJustReturn: "")
        self.outputs = Outputs(otp: otpDriver)

        let didFinishOTP = continueButton
            .withLatestFrom(otp)
            .map { Event.didFinishOTP($0) }

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
        case didFinishOTP(_ otp: String)
    }
}
