//
//  TasksTableViewController.swift
//  InnovationAgenda
//
//  Created by André Yamasaki on 03/07/21.
//

import UIKit

let work = Category(name: "work", color: .green)
let study = Category(name: "study", color: .blue)
let tasks: [Task] = [
    Task(id: UUID(), name: "Remember the presentation", date: Date(), category: study),
    Task(id: UUID(), name: "Call Janice", date: Date(), category: work)
]

class TasksTableViewController: UITableViewController {
    
    private var dateFormatter: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TasksTableViewCell
        let task = tasks[indexPath.row]
        
        dateFormatter.dateFormat = "HH:mm"
        cell.hourLabel.text = dateFormatter.string(from: task.date)
        
        dateFormatter.dateFormat = "DD/MM/yyyy"
        cell.dateLabel.text = dateFormatter.string(from: task.date)
        
        cell.categoryNameLabel.text = task.category.name
        cell.categoryView.backgroundColor = task.category.color
        cell.taskDescriptionLabel.text = task.name
        return cell
    }
}
