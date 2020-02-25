//
//  CoordinatorType.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation

protocol CoordinatorType {
    associatedtype Event
    func fsm(event: Event)
//    func start()
}
