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

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.viewModel.inputs
                .continueTappedObserver.onNext(())
        }

    }
}
