//
//  TagsViewController.swift
//  RealmDemo
//
//  Created by Hugues Stéphano TELOLAHY on 8/17/18.
//  Copyright © 2018 Hugues Stéphano TELOLAHY. All rights reserved.
//

import UIKit

class TagsViewController: UITableViewController {
    
    var taskName: String!
    
    private var presenter: TagsPresenter?
    
    private var items:[TagItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = TagsPresenter(view: self, dataManager: DataManager.shared, taskName: taskName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.onViewAppear()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.tagName
        cell.accessoryType = item.selected ? .checkmark  : .none
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TagsViewController: TagsView {
    
    func fill(tags: [TagItem]) {
        items = tags
        tableView.reloadData()
    }
}
