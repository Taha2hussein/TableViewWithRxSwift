//
//  RegisterViewModel.swift
//  RxSwiftTraining
//
//  Created by A on 14/12/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
class RegisterViewModel {
    
    var disposeBag = DisposeBag()
    var counter = BehaviorRelay<Int>(value: 0)
    
    func addCounter() {
        counter.accept(counter.value + 1)
    }

    func minusCounter() {
        guard  (counter.value) > 0 else{return}
        counter.accept(counter.value - 1)
    }
    
}
