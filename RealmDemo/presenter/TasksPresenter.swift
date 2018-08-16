//
//  TasksPresenter.swift
//  RealmDemo
//
//  Created by Hugues Stéphano TELOLAHY on 8/16/18.
//  Copyright © 2018 Hugues Stéphano TELOLAHY. All rights reserved.
//

protocol TasksView: AnyObject {
    func fill(tasks: [String])
}

class TasksPresenter {
    
    private weak var view: TasksView?
    
    private var tasks: [String] = []
    
    init(view: TasksView) {
       self.view = view
    }
    
    func onViewAppear() {
       view?.fill(tasks: tasks)
    }
    
    func onNewTaskAdded(name: String) {
        tasks.append(name)
        view?.fill(tasks: tasks)
    }
    
}
