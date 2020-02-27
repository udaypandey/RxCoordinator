//
//  Helper.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 27/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import Foundation

func indentPrint(_ indent: Int, _ items: Any...) {
    let prefix = String(repeating: ".  ", count: indent)
    if !prefix.isEmpty {
        print(prefix, terminator: "")
    }
    print(items)
}
