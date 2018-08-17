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
    
    init(view: TagsView, dataManager: IDataManager, taskName: String) {
        self.view = view
        self.dataManager = dataManager
        self.taskName = taskName
    }
    
    func onViewAppear() {
        let assignedTags = dataManager.loadTags(assignedTo: taskName)
        let allTags = dataManager.loadAllTags()
        let items = allTags.map { TagItem(tagName: $0, selected: assignedTags.contains($0)) }
        view.fill(tags: items)
    }
}

