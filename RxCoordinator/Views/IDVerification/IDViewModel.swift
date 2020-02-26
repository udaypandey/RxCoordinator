//
//  IDViewModel.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct IDViewModel: ViewModelType {
    let inputs: Inputs
    let outputs: Outputs
    let flows: Flows

    init() {
        let continueButton = PublishSubject<Void>()
        let verifyId = BehaviorSubject<String>(value: "Robert")

        self.inputs = Inputs(continueTappedObserver: continueButton.asObserver())

        let verifyIdDriver = verifyId.asDriver(onErrorJustReturn: "")
        self.outputs = Outputs(verifyId: verifyIdDriver)

        let didFinishID = continueButton
            .withLatestFrom(verifyId)
            .map { Event.didFinishID($0) }

        self.flows = Flows(didFinishID: didFinishID)
    }
}

extension IDViewModel {
    struct Inputs {
        let continueTappedObserver: AnyObserver<Void>
    }

    struct Outputs {
        let verifyId: Driver<String>
    }

    struct Flows {
        let didFinishID: Observable<Event>
    }

    enum Event {
        case didFinishID(_ verifyId: String)
    }
}
