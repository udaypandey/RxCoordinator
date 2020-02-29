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

struct Environment {
    var timer = DispatchTimeInterval.seconds(5)
}

let Current = Environment()

struct Model {
    var firstName: String

    func addUser(firstName: String, email: String) -> Observable<Bool> {
        indentPrint(4, "\(type(of: self)): addUser: start")

        return Observable<Bool>.create { observer in
            DispatchQueue.main.asyncAfter(deadline: .now() + Current.timer) {
                indentPrint(4, "\(type(of: self)): addUser: end")

                observer.onNext(true)
                observer.onCompleted()

            }

            return Disposables.create()
        }
    }

    func addUserPhone(phone: String) -> Observable<Bool> {
        indentPrint(4, "\(type(of: self)): addUserPhone: start")

        return Observable<Bool>.create { observer in
            DispatchQueue.main.asyncAfter(deadline: .now() + Current.timer) {
                indentPrint(4, "\(type(of: self)): addUserPhone: end")

                observer.onNext(true)
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }

    func verifyOTP(otp: String) -> Observable<Bool> {
        indentPrint(4, "\(type(of: self)): verifyOTP: start")

        return Observable<Bool>.create { observer in
            DispatchQueue.main.asyncAfter(deadline: .now() + Current.timer) {
                indentPrint(4, "\(type(of: self)): verifyOTP: end")

                observer.onNext(true)
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}

