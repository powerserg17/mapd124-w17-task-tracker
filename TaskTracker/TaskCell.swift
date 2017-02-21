//
//  TaskCell.swift
//  TaskTracker
//  300907406
//  Created by Serhii Pianykh on 2017-01-31.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//
//  UITableViewCell class with implemented methods for cell control

import UIKit

class TaskCell: UITableViewCell, UITextFieldDelegate {
    
    //checkbox images for button
    let imgChecked = UIImage(named: "checkbox-checked")
    let imgUnchecked = UIImage(named: "checkbox-unchecked")

    @IBOutlet var taskLabel: UILabel!
    
    @IBOutlet weak var addTitleField: UITextField!
    
    @IBOutlet var saveChangesBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    //closures for cell actions
    var doneTapAction: ((UITableViewCell) -> Void)?
    var saveTapAction: ((UITableViewCell) -> Void)?
    var cancelTapAction: ((UITableViewCell) -> Void)?
    
    var creating: Bool = false
    
    //setting up cells with passed task parameters
    //if in creating mode - show textfield and btns
    //if not - show labels and done btn
    //text crossed and faded if task is done
    func updateCell(task: Task) {
        if (creating) {
            creatingMode()
        } else {
            taskLabel.text = task.title
            if (task.done) {
                doneBtn.setImage(imgChecked, for: UIControlState.normal)
                let attributedString = NSMutableAttributedString(string: taskLabel.text!)
                attributedString.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue), range: NSMakeRange(0, attributedString.length))
                taskLabel.attributedText=attributedString
                taskLabel.textColor = UIColor.lightGray
            } else {
                doneBtn.setImage(imgUnchecked, for: UIControlState.normal)
                taskLabel.textColor = UIColor.white
            }
        }
    }
    
    //update task completion status
    func updateStatus(task: Task) {
        if task.done {
            task.done = false
            
        } else {
            task.done = true
        }
        task.ref?.updateChildValues(task.toAnyObject() as! [AnyHashable : Any])
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        doneTapAction?(self)
    }
    
    //setting up creating mode
    func creatingMode() {
        taskLabel.isHidden = true
        doneBtn.isHidden = true
        addTitleField.isHidden = false
        addTitleField.text = ""
        saveChangesBtn.isHidden = false
        cancelBtn.isHidden = false
        addTitleField.becomeFirstResponder()
    }
    
    //setting up view mode
    func viewMode() {
        taskLabel.isHidden = false
        doneBtn.isHidden = false
        addTitleField.isHidden = true
        addTitleField.text = ""
        saveChangesBtn.isHidden = true
        cancelBtn.isHidden = true
        addTitleField.resignFirstResponder()
    }

    
    @IBAction func saveChangesPressed(_ sender: UIButton) {
        saveTapAction?(self)
    }
    
    //saving changes for new task
    func saveChanges(task: Task) {
        self.creating = false
        task.creating = false
        task.title = addTitleField.text!
        self.viewMode()
        task.ref?.updateChildValues(task.toAnyObject() as! [AnyHashable : Any])
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.creating = false
        
        return true
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        cancelTapAction?(self)
    }
    
    //removing new task (canceling creation)
    func cancelChanges(task: Task) {
        self.creating = false
        task.ref?.removeValue()
    }
    
    
}
