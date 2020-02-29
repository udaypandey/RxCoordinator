//
//  OTPViewController.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class OTPViewController: UIViewController {
    var viewModel: OTPViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        title = "Validate OTP"

        indentPrint(3, "\(type(of: self)): viewDidLoad: start")
        DispatchQueue.main.asyncAfter(deadline: .now() + Current.timer) { [weak self] in
            indentPrint(3, "\(type(of: self)): viewDidLoad: end")

            self?.viewModel.inputs
                .continueTappedObserver.onNext(())
        }
    }
}
