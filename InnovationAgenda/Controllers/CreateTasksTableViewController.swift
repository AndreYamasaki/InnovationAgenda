//
//  CreateTasksTableViewController.swift
//  InnovationAgenda
//
//  Created by André Yamasaki on 04/07/21.
//

import UIKit

class CreateTasksTableViewController: UITableViewController, UITextFieldDelegate {
    
    //MARK: - Attributes
    
    private var datePicker: UIDatePicker = UIDatePicker()
    private var dateFormatter = DateFormatter()
    private var selectedIndexPath: IndexPath?
    
    private var taskRepository = TaskRepository.instance
    var task: Task = Task()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = .dateAndTime
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Task Name"
        } else if section == 1 {
            return "Category"
        } else {
            return "Date and Time"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskDescriptionCell", for: indexPath) as! TaskDescriptionTableViewCell
            cell.textDescriptionTextField.delegate = self
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            cell.textLabel?.text = self.task.category.name
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath) as! DateTimeTableViewCell
        cell.dateTimeTextField.inputView = datePicker
        cell.dateTimeTextField.delegate = self
        cell.dateTimeTextField.inputAccessoryView = accesssoryView()
        return cell
    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        taskRepository.save(task: task)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - UITextFieldDelegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let cell = textField.superview?.superview as? DateTimeTableViewCell
        if let dateCell = cell {
            self.selectedIndexPath = tableView.indexPath(for: dateCell)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.task.name = textField.text!
    }
    
    //MARK: - UIView functions
    
    func accesssoryView() -> UIView {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let barItemSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(CreateTasksTableViewController.selectDate))
        toolBar.setItems([barItemSpace, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }
    
    @objc func selectDate() {
        if let indexPath = self.selectedIndexPath {
            let cell = tableView.cellForRow(at: indexPath) as? DateTimeTableViewCell
            if let dateCell = cell {
                dateCell.dateTimeTextField.text = dateFormatter.string(from: datePicker.date)
                view.endEditing(true)
                self.task.date = datePicker.date
            }
        }
    }
    
    //MARK: - Segue methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCategoriesTableViewController" {
            let categoriesController = segue.destination as! CategoriesTableViewController
            categoriesController.choosenCategory = { (category) in
                self.task.category = category
                self.tableView.reloadData()
            }
        }
    }
}
