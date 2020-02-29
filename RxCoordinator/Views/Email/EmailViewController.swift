//
//  EmailViewController.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {
    var viewModel: EmailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        title = "Email"

        indentPrint(3, "\(type(of: self)): viewDidLoad: start")
        DispatchQueue.main.asyncAfter(deadline: .now() + Current.timer) { [weak self] in
            indentPrint(3, "\(type(of: self)): viewDidLoad: end")

            self?.viewModel.inputs
                .continueTappedObserver.onNext(())
        }

    }
}
