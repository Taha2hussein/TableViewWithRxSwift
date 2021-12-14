//
//  TodoAccessProvider.swift
//  RxSwiftTraining
//
//  Created by A on 13/12/2021.
//

import Foundation
import CoreData
import RxSwift
import RxRelay
class TodoAccessProvider {

    private var todosFromCoreData = BehaviorRelay<[Todo]>(value: [])
    private var managedObjectContext : NSManagedObjectContext

    init() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        todosFromCoreData.accept([Todo]())
        managedObjectContext = delegate.persistentContainer.viewContext

        todosFromCoreData.accept(fetchData())
    }

    // MARK: - fetching Todos from Core Data and update observable todos
    private func fetchData() -> [Todo] {
        let todoFetchRequest = Todo.fetchRequest()
        todoFetchRequest.returnsObjectsAsFaults = false

        do {
            return try managedObjectContext.fetch(todoFetchRequest)
        
        } catch {
            return []
        }

    }

    // MARK: - return observable todo
    public func fetchObservableData() -> Observable<[Todo]> {
        todosFromCoreData.accept(fetchData())
        return todosFromCoreData.asObservable()
    }

    // MARK: - add new todo from Core Data
    public func addTodo(withTodo todo: String) {
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: managedObjectContext) as! Todo

        newTodo.todoName = todo
        newTodo.isComplete = false

        do {
            try managedObjectContext.save()
            todosFromCoreData.accept(fetchData())
        } catch {
            fatalError("error saving data")
        }
    }

    // MARK: - toggle selected todo's isCompleted value
    public func toggleTodoIsCompleted(withIndex index: Int) {
        todosFromCoreData.value[index].isComplete = !todosFromCoreData.value[index].isComplete

        do {
            try managedObjectContext.save()
            todosFromCoreData.accept(fetchData())
        } catch {
            fatalError("error change data")
        }

    }

    // MARK: - remove specified todo from Core Data
    public func removeTodo(withIndex index: Int) {
        managedObjectContext.delete(todosFromCoreData.value[index])

        do {
            try managedObjectContext.save()
            todosFromCoreData.accept(fetchData())
        } catch {
            fatalError("error delete data")
        }
    }

}
