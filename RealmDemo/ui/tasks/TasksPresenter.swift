//
//  TasksPresenter.swift
//  RealmDemo
//
//  Created by Hugues Stéphano TELOLAHY on 8/16/18.
//  Copyright © 2018 Hugues Stéphano TELOLAHY. All rights reserved.
//

protocol TasksView: class {
    func fill(tasks: [String])
}

class TasksPresenter {
    
    private unowned let view: TasksView
    private unowned let dataManager: IDataManager
    
    init(view: TasksView, dataManager: IDataManager) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func onViewAppear() {
        let tasks = dataManager.loadAllTasks()
        view.fill(tasks: tasks)
    }
    
    func onTaskAdded(name: String) {
        guard dataManager.addTask(name: name) else {
            // TODO: failed adding task
            return
        }
        
        let tasks = dataManager.loadAllTasks()
        view.fill(tasks: tasks)
    }
}
