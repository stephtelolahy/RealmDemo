//
//  DataManager.swift
//  RealmDemo
//
//  Created by Hugues Stéphano TELOLAHY on 8/16/18.
//  Copyright © 2018 Hugues Stéphano TELOLAHY. All rights reserved.
//

// https://realm.io/docs/swift/latest/
import RealmSwift

protocol IDataManager : class {
    func loadAllTasks() -> [String]
    func addTask(name: String) -> Bool
    func loadTags(assignedTo taskName: String) -> [String]
    func loadAllTags() -> [String]
    func addTag(name: String) -> Bool
    func assign(taskName: String, tags assignedTags: [String])
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
    
    func assign(taskName: String, tags assignedTags: [String]) {
        guard let task = realm.objects(Task.self).filter(" name = '\(taskName)'").first else {
            return
        }
        let tags = realm.objects(Tag.self)
        for tag in tags {
            if assignedTags.contains(tag.name) {
                add(task: task, tag: tag)
            } else {
                remove(task: task, tag: tag)
            }
        }
    }
    
    private func add(task: Task, tag: Tag) {
        guard !tag.members.contains(where: { $0.name == task.name }) else {
            return
        }
        try! realm.write {
            tag.members.append(task)
        }
    }
    
    private func remove(task: Task, tag: Tag) {
        guard  let index = tag.members.index(where: { $0.name == task.name }) else {
            return
        }
        try! realm.write {
            tag.members.remove(at: index)
        }
    }
    
    func loadTags(assignedTo taskName: String) -> [String] {
        guard let task = realm.objects(Task.self).filter(" name = '\(taskName)'").first else {
            return []
        }
        return Array(task.associatedTags).map { $0.name }
    }
}
