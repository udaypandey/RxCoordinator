//
//  Model.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct Model {
    var firstName: String

    func addUser(firstName: String, email: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            observer.onNext(true)
            observer.onCompleted()

            return Disposables.create()
        }
    }

    func addUserPhone(phone: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            observer.onNext(true)
            observer.onCompleted()

            return Disposables.create()
        }
    }

    func verifyOTP(otp: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            observer.onNext(true)
            observer.onCompleted()

            return Disposables.create()
        }
    }
}

