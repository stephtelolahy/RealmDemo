//
//  DataManager.swift
//  RealmDemo
//
//  Created by Hugues Stéphano TELOLAHY on 8/16/18.
//  Copyright © 2018 Hugues Stéphano TELOLAHY. All rights reserved.
//

import RealmSwift

protocol IDataManager : class {
    func loadTasks() -> [String]
    func addNewTask(name: String) -> Bool
}

class DataManager: IDataManager {
    
    static let shared = DataManager()
    
    let realm = try! Realm()
    
    func loadTasks() -> [String] {
        let taskNames  = realm.objects(Task.self).map { $0.name }
        return Array(taskNames)
    }
    
    func addNewTask(name: String) -> Bool {
        let task = Task()
        task.name = name
        
        try! realm.write {
            realm.add(task)
        }
        
        return true
    }
    
}
