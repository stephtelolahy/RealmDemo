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
        let selectedTask = tasks[indexPath.row]
        self.performSegue(withIdentifier: "toTags", sender: selectedTask)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: IBActions
    
    @IBAction func onAddTaped(_ sender: Any) {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "New task", message: "", preferredStyle: .alert)
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }
        
        //the confirm action taking the input
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            
            //getting the input value from user
            if let name = alertController.textFields?[0].text, !name.isEmpty {
                self.presenter?.onNewTaskAdded(name: name)
            }
        }
        alertController.addAction(confirmAction)
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
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
        self.tableView.reloadData()
    }
}
