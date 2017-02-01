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
    
    var testArray = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        testArray.append(Task(title: "Wash dishes"))
        testArray.append(Task(title: "Finish assignment"))
        testArray.append(Task(title: "Find a job"))
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell {
            cell.updateCell(task: testArray[indexPath.row])
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
        }
    }


}

