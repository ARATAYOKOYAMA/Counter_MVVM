//
//  SampleViewModel.swift
//  Counter_MVVM
//
//  Created by 横山新 on 2019/02/11.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SampleViewModel {
    // MARK: Inputなので，Observerのみ外部から参照できるように
    private let viewWillAppearStream = PublishSubject<Void>()
    private let plussButtonDidTapStream = PublishSubject<Void>()
    private let minusButtonDidTapStream = PublishSubject<Void>()
    
    var viewWillAppear: AnyObserver<()> {
        return viewWillAppearStream.asObserver()
    }
    
    var plussButtonDidTap: AnyObserver<()> {
        return plussButtonDidTapStream.asObserver()
    }
    
    var minusButtonDidTap: AnyObserver<()> {
        return minusButtonDidTapStream.asObserver()
    }
    
    // MARK: Outputなので，Observableのみ外部から参照できるように
    
    private let countStream = PublishSubject<Int>()
    
    var count: Observable<Int> {
        return countStream.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    init(model: SampleModelInput) {
        
        viewWillAppearStream
            .flatMapLatest { _ -> Observable<Int> in
                return model.fetchCount()
        }
        .bind(to: countStream)
        .disposed(by: disposeBag)
        
        plussButtonDidTapStream.subscribe(onNext: { [] in
            model.countUp()
        })
        .disposed(by: disposeBag)
        
        minusButtonDidTapStream.subscribe(onNext: { [] in
            model.countDown()
        })
        .disposed(by: disposeBag)
        
    }
}
