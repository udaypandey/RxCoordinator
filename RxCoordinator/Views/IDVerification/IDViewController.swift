//
//  IDViewController.swift
//  RxCoordinator
//
//  Created by Uday Pandey on 25/02/2020.
//  Copyright © 2020 TSBMobile. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class IDViewController: UIViewController {
    var viewModel: IDViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .magenta
        title = "Verifiy ID"

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.viewModel.inputs
                .continueTappedObserver.onNext(())
        }
    }
}
