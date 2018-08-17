//
//  TasksViewController.swift
//  RealmDemo
//
//  Created by Hugues Stéphano TELOLAHY on 8/16/18.
//  Copyright © 2018 Hugues Stéphano TELOLAHY. All rights reserved.
//

import UIKit

class TasksViewController: UITableViewController {
    
    private var presenter: TasksPresenter?
    
    private var tasks:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = TasksPresenter(view: self, dataManager: DataManager.shared)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.onViewAppear()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedTask = tasks[indexPath.row]
        performSegue(withIdentifier: "toTags", sender: selectedTask)
    }
    
    // MARK: IBActions
    
    @IBAction func onAddTaped(_ sender: Any) {
        presentInputDialog(title: "New task", textFieldPlaceHolder: "Enter Name", confirmActionTitle: "Add") { name in
            self.presenter?.onTaskAdded(name: name)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let tagsViewController = segue.destination as? TagsViewController
        // Pass the selected object to the new view controller.
        let taskName = sender as? String
        tagsViewController?.taskName = taskName
    }
    
}

extension TasksViewController: TasksView {
    
    func fill(tasks: [String]) {
        self.tasks = tasks
        tableView.reloadData()
    }
}
