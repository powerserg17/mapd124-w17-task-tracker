//
//  ViewController.swift
//  TaskTracker
//
//  Created by Serhii Pianykh on 2017-01-31.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit

class ListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    let storageRef = FIRDatabase.database().reference(withPath: "storage")
    var tasksRef: FIRDatabaseReference? = nil
    
    var user: User? = nil
    
    var tasks = [Task]()
    
    var creating:Bool = false
    
    
    
    @IBOutlet var addTaskField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let connectedRef = FIRDatabase.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
            if let connected = snapshot.value as? Bool, connected {
                self.navigationItem.titleView = CustomTitle(frame: CGRect(), user: (self.user?.email)!, status: connected)
            }
        })
        
        FIRAuth.auth()!.addStateDidChangeListener { auth, user in
            if let user = user {
                self.user = User(authData: user)
                self.navigationItem.title = user.email
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        tasksRef = storageRef.child((FIRAuth.auth()?.currentUser?.uid)!)
        
        tasksRef?.queryOrdered(byChild: "done").observe(.value, with: { snapshot in
            var newTasks = [Task]()
            var tasksInProgress = false
            for item in snapshot.children {
                let task = Task(snapshot: item as! FIRDataSnapshot)
                if task.creating {
                    tasksInProgress = true
                }
                newTasks.append(task)
            }
            if tasksInProgress {
                self.creating = true
            } else {
                self.creating = false
            }
            self.tasks = newTasks
            self.tableView.reloadData()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell {
            let task = tasks[indexPath.row]
            
            if task.creating {
                cell.creating = true
            }
            
            cell.doneTapAction = { (self) in
                cell.updateStatus(task: task)
            }
            
            cell.saveTapAction = { (self) in
                cell.saveChanges(task: task)
                //tableView.reloadRows(at: [indexPath], with: .automatic)
            }

            cell.cancelTapAction = {(self) in
                cell.cancelChanges(task: task)
                //tableView.reloadRows(at: [indexPath], with: .automatic)
                
            }
            cell.updateCell(task: task)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        performSegue(withIdentifier: "DetailsVC", sender: task)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsVC {
            if let task = sender as? Task {
                destination.task = task
            }
            
            if creating {
                for task in tasks {
                    if task.creating {
                        task.ref?.removeValue()
                    }
                }
            }
//            if creating {
//                 if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: IndexPath(row: 0, section: 0)) as? TaskCell {
//                    removeFirstRow()
//                    cell.creating = false
//                }
//            }
        }
    }

    @IBAction func addPressed(_ sender: Any) {
        if !creating {
            //creating = true
//            tableView.beginUpdates()
//            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .none)
//            tasks.insert(Task(title: ""), at: 0)
//            tableView.endUpdates()
//            tableView.reloadData()
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: IndexPath(row: 0, section: 0)) as! TaskCell
//                        cell.creating = true
//            tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            //tableView.reloadData()
            let task = Task(title: "")
            let taskRef = self.tasksRef!.childByAutoId()
            task.ref = taskRef
            taskRef.setValue(task.toAnyObject())
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            task.ref?.removeValue()
        }
    }
    
    
    
    
//    @IBAction  func saveChanges(_ sender: Any) {
//        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TaskCell
//        let task = tasks[0]
//        cell.saveChanges(task: task)
//        creating = false
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
//        tableView.reloadData()
//        let taskRef = self.tasksRef!.childByAutoId()
//        task.id = taskRef.key
//        taskRef.setValue(task.toAnyObject())
//    }
//    

//    @IBAction func cancelChanges(_ sender: UIButton) {
//        removeFirstRow()
//        tableView.reloadData()
//    }
    
//    func removeFirstRow() {
//        tableView.beginUpdates()
//        tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
//        tasks.remove(at: 0)
//        creating = false
//        tableView.endUpdates()
//        creating = false
//        let task = tasks[0]
//        task.ref?.removeValue()
//    }
    
    
    @IBAction func signOutPressed(_ sender: Any) {
        try! FIRAuth.auth()!.signOut()
    }
}

