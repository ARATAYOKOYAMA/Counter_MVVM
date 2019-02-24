//
//  SampleModel.swift
//  Counter_MVVM
//
//  Created by 横山新 on 2019/02/11.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SampleModelInput {
    func countUp()
    func countDown()
    func fetchCount() -> Observable<Int>
}

final class SampleModel: SampleModelInput {
    
    // MARK: coutとcountBehaviorが別の形で宣言されているのが気持ち悪い
    private var count = 0
    private let countBehavior = BehaviorRelay(value: 0)
    
    var countObservable: Observable<Int> {
        return countBehavior.asObservable()
    }
    
    func countUp() {
        count += 1
        countBehavior.accept(count)
    }
    
    func countDown() {
        count -= 1
        countBehavior.accept(count)
    }
    
    func fetchCount() -> Observable<Int> {
        return countObservable
    }
}

