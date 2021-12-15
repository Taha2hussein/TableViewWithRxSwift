//
//  RegisterViewController.swift
//  RxSwiftTraining
//
//  Created by A on 14/12/2021.
//

import UIKit
import RxKeyboard
import RxSwift
import RxCocoa
import RxGesture
class RegisterViewController:  BaseViewController  {

    @IBOutlet weak var gestureView: UIView!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    
    private var RegisterViewModelInstance = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.keyBoard(withPush: true)
        recognizedView()
        bindPlus()
        bindMinus()
        bindcounterLabel()
        
    }
    
    
    func bindPlus() {
        plusBtn.rx.tap.subscribe { plusCount in
            self.RegisterViewModelInstance.addCounter()
        } .disposed(by: disposeBag)
    }
    
    func bindMinus() {
        minusBtn.rx.tap.subscribe { plusCount in
            self.RegisterViewModelInstance.minusCounter()
        } .disposed(by: disposeBag)
    }

    func bindcounterLabel() {
        self.RegisterViewModelInstance.counter.subscribe { value in
            self.counterLabel.text = "\(value.element ?? 0)"
        } .disposed(by: disposeBag)

    }
    
    private func recognizedView() {
        gestureView.rx
          .tapGesture()
          .when(.recognized)
          .subscribe(onNext: { _ in
            //react to taps
              self.gestureView.backgroundColor = .black
          })
          .disposed(by: disposeBag)
    }
}


