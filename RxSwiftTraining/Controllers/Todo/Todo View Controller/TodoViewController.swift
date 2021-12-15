//
//  TodoViewController.swift
//  RxSwiftTraining
//
//  Created by A on 13/12/2021.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa
class TodoViewController: checkInternetViewController {

    @IBOutlet weak var addTaskButton: UIBarButtonItem!
    @IBOutlet weak var todoTableView: UITableView!
    
    var TodoViewModelInstance = TodoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTodoTasksTotableView()
        addTaskAction()
        fetchData()
        deleteTask()
        setTaskAsCompleted()
        selectTask()
    }
    
    func fetchData(){
        self.TodoViewModelInstance.fetchTodoTasks()
    }
    
    func selectTask(){
        Observable.zip(self.todoTableView.rx.itemSelected, self.todoTableView.rx.modelSelected(Todo.self)).bind{
            todo , index in
            
            let todoViewController = UIStoryboard.init(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")as! RegisterViewController
            
            self.navigationController?.pushViewController(todoViewController, animated: true)
            
        }.disposed(by: self.disposeBag)
    }
    
    func bindTodoTasksTotableView(){
        self.TodoViewModelInstance.todoTasksObservable
            .bind(to: self.todoTableView
            .rx
            .items(cellIdentifier: String(describing:  TodoTableViewCell.self),
                           cellType: TodoTableViewCell.self)) { row, model, cell in
                cell.configure(todo: model)
            }.disposed(by: disposeBag)
    }

    func addTaskAction(){
        addTaskButton
            .rx.tap
            .subscribe(
                onNext: {
                    let addTodoAlert = UIAlertController(title: "Add Todo", message: "Enter your Task", preferredStyle: .alert)
                    
                    addTodoAlert.addTextField(configurationHandler: nil)
                    addTodoAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { al in
                        let todoString = addTodoAlert.textFields![0].text
                        if !(todoString!.isEmpty) {
                            self.TodoViewModelInstance.addTask(taskName: todoString!)
                        }
                    }))
                    
                    addTodoAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    
                    self.present(addTodoAlert, animated: true, completion: nil)
                }
            )
            .disposed(by:disposeBag)
    }
    
    
    func deleteTask(){
        self.todoTableView.rx.itemDeleted.subscribe { indexPath in
            self.TodoViewModelInstance.deleteTask(index: indexPath.row)
        } .disposed(by: disposeBag)

    }
    
    func setTaskAsCompleted(){
        self.todoTableView.rx.itemSelected.subscribe { indexPath in
            self.TodoViewModelInstance.setTaskAsChecked(index: indexPath.row)
        } .disposed(by: disposeBag)

    }
}
