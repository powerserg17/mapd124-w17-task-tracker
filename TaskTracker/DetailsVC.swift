//
//  DetailsVC.swift
//  TaskTracker
//  300907406
//  Created by Serhii Pianykh on 2017-01-31.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//
//  ViewController with detailed information about selected task. Can be edited

import UIKit

class DetailsVC: UIViewController {
    
    private var _task : Task!
    
    var task: Task {
        get {
            return _task
        }
        
        set {
            _task = newValue
        }
    }

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var notesView: UITextView!
    @IBOutlet weak var doneSwitch: UISwitch!
    
    //load passed task parameters to view
    override func viewDidLoad() {
        super.viewDidLoad()

        titleField.text=task.title
        notesView.text=task.details
        if task.done {
            doneSwitch.isOn = true
        } else {
            doneSwitch.isOn = false
        }
    }
    
    //update storage and go back to ListVC
    @IBAction func savePressed(_ sender: UIButton) {
        task.details = notesView.text
        task.done = doneSwitch.isOn
        task.title = titleField.text!
        
        task.ref?.updateChildValues(task.toAnyObject() as! [AnyHashable : Any])
        
        _ = navigationController?.popViewController(animated: true)
    }

}
