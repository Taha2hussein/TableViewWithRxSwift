//
//  UseCaseProtocols.swift
//  RxSwiftTraining
//
//  Created by A on 07/12/2021.
//

import Foundation

import RxSwift
protocol UseCaseProtocols {
    func fetchProduct(page_Pagination:Int)
}
protocol TodoTasks{
    func fetchTodoTasks()
}

protocol addTaskProtocol {
    func addTask(taskName:String)
}

protocol deleteTask {
    func deleteTask(index:Int)
}
protocol toogleTaskIsComplete {
    func setTaskAsChecked(index:Int)
}
