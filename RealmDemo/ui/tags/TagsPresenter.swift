//
//  TagsPresenter.swift
//  RealmDemo
//
//  Created by Hugues Stéphano TELOLAHY on 8/17/18.
//  Copyright © 2018 Hugues Stéphano TELOLAHY. All rights reserved.
//

class TagItem {
    let tagName: String
    var selected: Bool
    
    init(tagName: String, selected: Bool) {
        self.tagName = tagName
        self.selected = selected
    }
}

protocol TagsView: class {
    func fill(tags: [TagItem])
}

class TagsPresenter {
    
    private unowned let view: TagsView
    private unowned let dataManager: IDataManager
    private let taskName: String
    private var items: [TagItem] = []
    
    init(view: TagsView, dataManager: IDataManager, taskName: String) {
        self.view = view
        self.dataManager = dataManager
        self.taskName = taskName
    }
    
    func onViewAppear() {
        let assignedTags = dataManager.loadTags(assignedTo: taskName)
        let allTags = dataManager.loadAllTags()
        items = allTags.map { TagItem(tagName: $0, selected: assignedTags.contains($0)) }
        view.fill(tags: items)
    }
    
    func onTagAdded(name: String) {
        guard dataManager.addTag(name: name) else {
            // TODO: failed adding tag
            return
        }
        
        items.append(TagItem(tagName: name, selected: true))
        view.fill(tags: items)
    }
    
    func onTagSelected(name: String) {
        guard let item = items.first(where: { $0.tagName == name }) else {
            return
        }
        item.selected = !item.selected
        view.fill(tags: items)
    }
    
    func onViewDisappear() {
        let assignedTags = items.filter { $0.selected }.map { $0.tagName }
        dataManager.assign(taskName: taskName, tags: assignedTags)
    }
}

