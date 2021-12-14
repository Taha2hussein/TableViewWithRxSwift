//
//  TodoViewModel.swift
//  RxSwiftTraining
//
//  Created by A on 13/12/2021.
//

import Foundation
import RxRelay
import RxSwift

class TodoViewModel : TodoTasks{
    private var disposeBag = DisposeBag()
    private var todoDataAccessProvider = TodoAccessProvider()
    private var todoTasks = PublishSubject<[Todo]>()
    var todoTasksObservable : Observable<[Todo]> {
        return todoTasks
    }
    
    func fetchTodoTasks() {
        todoDataAccessProvider.fetchObservableData()
            .map({ $0 })
            .subscribe(onNext : { (todos) in
                print("todos",todos)
                self.todoTasks.onNext(todos)
            })
            .disposed(by:disposeBag)
    }
    
}

extension TodoViewModel:addTaskProtocol{
    func addTask(taskName: String) {
        self.todoDataAccessProvider.addTodo(withTodo: taskName)
    }
}

extension TodoViewModel : deleteTask{
    func deleteTask(index: Int) {
        self.todoDataAccessProvider.removeTodo(withIndex: index)
    }
}

extension TodoViewModel : toogleTaskIsComplete {
    func setTaskAsChecked(index: Int) {
        self.todoDataAccessProvider.toggleTodoIsCompleted(withIndex: index)
    }
    
    
}
