//
//  ProductViewController.swift
//  RxSwiftTraining
//
//  Created by A on 07/12/2021.
//

import UIKit
import RxSwift
import RxRelay
import RxReachability
import RxCocoa

class ProductViewController: BaseViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    

    var disopseBag = DisposeBag()
    var productViewModel = ProductViewModel()
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestProduct()
        bindDataToTableView()
        subscribeToLoading()
        subscribeToHideTableView()
        selectProduct()
        subscribetoRefresher()
    }
    
    
    func requestProduct() {
        productViewModel.fetchProduct()
    }
    
    func subscribeToHideTableView() {
        productViewModel.state.isProductTableViewHide.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.productTableView.isHidden = true
                
            } else {
                self.productTableView.isHidden = false
            }
        }).disposed(by: disopseBag)
    }
    
    func subscribeToLoading() {
        productViewModel.state.isLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoading()
                
            } else {
                self.HideLoading()
            }
        }).disposed(by: disopseBag)
    }
    
    func bindDataToTableView() {
        self.productViewModel.productSubjectObservable
            .bind(to: self.productTableView
            .rx
            .items(cellIdentifier: String(describing:  ProductCell.self),
                           cellType: ProductCell.self)) { row, model, cell in
                
                cell.setData( product:model)
                cell.configure(image: model.image ?? "")
            }.disposed(by: disopseBag)
    }
    
    func selectProduct() {
        Observable.zip(productTableView
                        .rx
                        .itemSelected,productTableView.rx.modelSelected(Datum.self)).bind {  selectedIndex, product in
            
            print(selectedIndex, product.name ?? "")
        }
        .disposed(by: disopseBag)
    }
    
    func subscribetoRefresher() {
        //
       
        
    }
    
    func paginationTableView() {
//        productViewModel.page_Pagination.subscribe { page in
//            //
//        }.disposed(by: disopseBag)

        self.productTableView.rx.
    }
}
