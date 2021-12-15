//
//  ProductViewModel.swift
//  RxSwiftTraining
//
//  Created by A on 07/12/2021.
//

import Foundation
import RxSwift
import Alamofire
import RxRelay


class ProductViewModel  : UseCaseProtocols {
    

    var productSubject =  PublishSubject<[Datum]>()
    var page_Pagination = BehaviorRelay<Int>(value:0)
    private var disposeBag = DisposeBag()
    var state = State()
    var productSubjectObservable: Observable<[Datum]> {
        return productSubject
    }
     
  
    func fetchProduct(page_Pagination:Int) {
        
        state.isLoading.accept(true)
        let parameters = ["page" : page_Pagination]
        NetWorkManager.instance.API(method: .get, url: proudct,parameters:parameters) { [weak self](err, status, response:ProductModel?) in
            guard let self = self else { return }
            self.state.isLoading.accept(false)
            if let error = err {
                print(error.localizedDescription)
            }  else {
                guard let branchesModel = response else { return }
                print(branchesModel)
                if branchesModel.data?.data?.count ?? 0 > 0 {
                    self.productSubject.onNext(branchesModel.data?.data ?? [])
                    self.page_Pagination.accept(branchesModel.data?.total ?? 0)
                    self.state.isProductTableViewHide.accept(false)
                } else {
                    self.state.isProductTableViewHide.accept(true)
                }
            }
        }
    }

}
