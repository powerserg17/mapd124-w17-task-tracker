//
//  ListVC.swift
//  TaskTracker
//  300907406
//  Created by Serhii Pianykh on 2017-01-31.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//
//  ViewController with all tasks listed

import UIKit

class ListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    //defining references for db
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
        
        //getting online/offline status
        let connectedRef = FIRDatabase.database().reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
            if let connected = snapshot.value as? Bool, connected {
                self.navigationItem.titleView = CustomTitle(frame: CGRect(), user: (self.user?.email)!, status: connected)
            }
        })
        
        //observing changes in login status (basically we look, if currentuser exist)
        FIRAuth.auth()!.addStateDidChangeListener { auth, user in
            if let user = user {
                self.user = User(authData: user)
                self.navigationItem.title = user.email
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
        //assigning current user to his storage
        tasksRef = storageRef.child((FIRAuth.auth()?.currentUser?.uid)!)
        
        //observing changes and uploading data from db and updating tableview
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
            //defining actions for cell closures
            cell.doneTapAction = { (self) in
                cell.updateStatus(task: task)
            }
            
            cell.saveTapAction = { (self) in
                cell.saveChanges(task: task)
            }

            cell.cancelTapAction = {(self) in
                cell.cancelChanges(task: task)
            }
            //assigning task parameters to cell
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
    
    //we have set up Task object as a sender in performSegue. here we check if it's so and sending Task object to next VC
    //if some of cells were in creation mode (with textfield shown) - cell being deleted
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
        }
    }

    //create new task. it's going to be in creation mode (from init), so after table view updated textfield gonna be shown
    @IBAction func addPressed(_ sender: Any) {
        if !creating {
            let task = Task(title: "")
            let taskRef = self.tasksRef!.childByAutoId()
            task.ref = taskRef
            taskRef.setValue(task.toAnyObject())
        }
    }
    
    //swipe for delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            task.ref?.removeValue()
        }
    }
    
    //sign out
    @IBAction func signOutPressed(_ sender: Any) {
        try! FIRAuth.auth()!.signOut()
    }
}

