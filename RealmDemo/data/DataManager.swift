//
//  DataManager.swift
//  RealmDemo
//
//  Created by Hugues Stéphano TELOLAHY on 8/16/18.
//  Copyright © 2018 Hugues Stéphano TELOLAHY. All rights reserved.
//

import RealmSwift

protocol IDataManager : class {
    func loadAllTasks() -> [String]
    func addTask(name: String) -> Bool
    func loadTags(assignedTo taskName: String) -> [String]
    func loadAllTags() -> [String]
    func addTag(name: String) -> Bool
    func associate(taskName: String, withTags tagNames: [String])
}

class DataManager: IDataManager {
    
    static let shared = DataManager()
    
    let realm = try! Realm()
    
    func loadAllTasks() -> [String] {
        return Array(realm.objects(Task.self).map { $0.name })
    }
    
    func addTask(name: String) -> Bool {
        let task = Task()
        task.name = name
        try! realm.write {
            realm.add(task)
        }
        return true
    }
    
    func loadTags(assignedTo taskName: String) -> [String] {
        // TODO:
        return ["Family", "Work"]
    }
    
    func loadAllTags() -> [String] {
        return Array(realm.objects(Tag.self).map { $0.name })
    }
    
    func addTag(name: String) -> Bool {
        let tag = Tag()
        tag.name = name
        try! realm.write {
            realm.add(tag)
        }
        return true
    }
    
    func associate(taskName: String, withTags tagNames: [String]){
        // TODO:
    }
}
