//
//  ViewModelType.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Inputs
    associatedtype Outputs
    associatedtype Flows

    var inputs: Inputs { get }
    var outputs: Outputs { get }
    var flows: Flows { get }
}

