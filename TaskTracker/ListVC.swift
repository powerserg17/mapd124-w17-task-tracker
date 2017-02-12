//
//  ViewController.swift
//  TaskTracker
//
//  Created by Serhii Pianykh on 2017-01-31.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var ref : FIRDatabaseReference! = nil
    
    var testArray = [Task]()
    
    var creating:Bool = false
    
    @IBOutlet var addTaskField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref =  FIRDatabase.database().reference(withPath: "tasks")
        
        testArray.append(Task(title: "Wash dishes"))
        testArray.append(Task(title: "Finish assignment"))
        testArray.append(Task(title: "Find a job"))
        let task = Task(title: "Don't give a shit")
        task.done = true
        testArray.append(task)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell {
            let task = testArray[indexPath.row]
            
            cell.updateCell(task: task)
            
            cell.doneTapAction = { (self) in
                cell.updateStatus(task: task)
            }
            
//            cell.saveTapAction = { (self) in
//                cell.saveChanges(task: task)
//                tableView.reloadRows(at: [indexPath], with: .automatic)
//            }
//
//            cell.cancelTapAction = {(self) in
//                tableView.beginUpdates()
//                tableView.deleteRows(at: [indexPath], with: .fade)
//                tableView.endUpdates()
//            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = testArray[indexPath.row]
        performSegue(withIdentifier: "DetailsVC", sender: task)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsVC {
            if let task = sender as? Task {
                destination.task = task
            }
            if creating {
                 if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: IndexPath(row: 0, section: 0)) as? TaskCell {
                    removeFirstRow()
                    cell.creating = false
                }
            }
        }
    }

    @IBAction func addPressed(_ sender: Any) {
        if !creating {
            creating = true
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .none)
            testArray.insert(Task(title: ""), at: 0)
            tableView.endUpdates()
            tableView.reloadData()
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: IndexPath(row: 0, section: 0)) as! TaskCell
                        cell.creating = true
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            //tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            testArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    
    @IBAction  func saveChanges(_ sender: Any) {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TaskCell
        let task = testArray[0]
        cell.saveChanges(task: task)
        creating = false
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.reloadData()
        print(creating)
    }
    

    @IBAction func cancelChanges(_ sender: UIButton) {
        removeFirstRow()
        tableView.reloadData()
    }
    
    func removeFirstRow() {
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        testArray.remove(at: 0)
        creating = false
        tableView.endUpdates()
    }
}

