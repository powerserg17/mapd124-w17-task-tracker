//
//  DetailsVC.swift
//  TaskTracker
//
//  Created by Serhii Pianykh on 2017-01-31.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

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

}
