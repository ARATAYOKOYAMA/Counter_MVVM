//
//  ViewController.swift
//  Counter_MVVM
//
//  Created by 横山新 on 2019/02/11.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SampleViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var PlusButton: UIButton!
    @IBOutlet weak var MiusButton: UIButton!
    
    private lazy var viewModel = SampleViewModel(
        model: SampleModel()
    )
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Output
        rx.sentMessage(#selector(viewWillAppear(_:)))
            .map { _ in }
            .bind(to: viewModel.viewWillAppear)
            .disposed(by: disposeBag)
        
        PlusButton.rx.tap
            .bind(to: viewModel.plussButtonDidTap)
            .disposed(by: disposeBag)
        
        MiusButton.rx.tap
            .bind(to: viewModel.minusButtonDidTap)
            .disposed(by: disposeBag)
        

        // MARK: Input
        // MARK: bindではなくsubscribeでも実現できるが，UIと結びつけるためのバインディングなので，bindを使用する
        viewModel.count
            .bind(onNext: { [weak self] count in
                self?.label.text = String(count)
            })
            .disposed(by: disposeBag)

    }
    

}

