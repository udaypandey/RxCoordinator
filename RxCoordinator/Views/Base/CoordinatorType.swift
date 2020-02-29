//
//  CoordinatorType.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation
import RxSwift

protocol CoordinatorType {
    associatedtype Event

    func start()
}

protocol ChildCoordinatorType: CoordinatorType {
    var disposeBag: DisposeBag { get }
}
