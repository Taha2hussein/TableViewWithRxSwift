//
//  ProductViewController.swift
//  RxSwiftTraining
//
//  Created by A on 07/12/2021.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class ProductViewController: BaseViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    
    fileprivate let refreshControl = UIRefreshControl()
    var disopseBag = DisposeBag()
    var productViewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        prepareUI()
        bindRefreshControl()
        requestProduct()
        bindDataToTableView()
        subscribeToLoading()
        subscribeToHideTableView()
        selectProduct()
    }
    
 
    
//    private func prepareUI() {
//
//        // Preparing refreshcontrol
//        refresh.attributedTitle = NSAttributedString(string: "")
//        if #available(iOS 10.0, *) {
//            productTableView.refreshControl = refresh
//        } else {
//            productTableView.addSubview(refresh)
//        }
//    }
//
    func bindRefreshControl(){
        refreshControl.rx.controlEvent(.valueChanged)
                    .subscribe(onNext: {[weak self]
                        _ in
                        self?.requestProduct()
                        self?.refreshControl.endRefreshing()
                    }).disposed(by: disposeBag)
                
        productTableView.addSubview(refreshControl)
    }
    func requestProduct() {
        productViewModel.fetchProduct(page_Pagination: self.productViewModel.page_Pagination.value)
    }
    
    func subscribeToHideTableView() {
        productViewModel.state.isProductTableViewHide.subscribe(onNext: {[weak self] (isLoading) in
            if isLoading {
                self?.productTableView.isHidden = true
                
            } else {
                self?.productTableView.isHidden = false
            }
        }).disposed(by: disopseBag)
    }
    
    func subscribeToLoading() {
        productViewModel.state.isLoading.subscribe(onNext: {[weak self] (isLoading) in
            if isLoading {
                self?.showLoading()
                
            } else {
                self?.HideLoading()
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
                        .itemSelected,productTableView.rx.modelSelected(Datum.self)).bind { [weak self] selectedIndex, product in
            let todoViewController = UIStoryboard.init(name: "todoView", bundle: nil).instantiateViewController(withIdentifier: "TodoViewController")as! TodoViewController
            self?.navigationController?.pushViewController(todoViewController, animated: true)
            print(selectedIndex, product.name ?? "")
        }
        .disposed(by: disopseBag)
    }
}
