//
//  TaskCell.swift
//  TaskTracker
//
//  Created by Serhii Pianykh on 2017-01-31.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell, UITextFieldDelegate {
    
    let imgChecked = UIImage(named: "checkbox-checked")
    let imgUnchecked = UIImage(named: "checkbox-unchecked")

    @IBOutlet var taskLabel: UILabel!
    
    @IBOutlet weak var addTitleField: UITextField!
    
    @IBOutlet var saveChangesBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    var doneTapAction: ((UITableViewCell) -> Void)?
    var saveTapAction: ((UITableViewCell) -> Void)?
    var cancelTapAction: ((UITableViewCell) -> Void)?
    
    var creating: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTitleField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
    
    func updateStatus(task: Task) {
        if task.done {
            task.done = false
        } else {
            task.done = true
        }
        updateCell(task: task)
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        doneTapAction?(self)
    }
    
    
    func creatingMode() {
        taskLabel.isHidden = true
        doneBtn.isHidden = true
        addTitleField.isHidden = false
        addTitleField.text = ""
        saveChangesBtn.isHidden = false
        cancelBtn.isHidden = false
        addTitleField.becomeFirstResponder()
    }

    
    @IBAction func saveChangesPressed(_ sender: UIButton) {
        saveTapAction?(self)
    }
    
    func saveChanges(task: Task) {
        print(self.addTitleField.text!)
        self.creating = false
        task.title = addTitleField.text!
        print(task.title)
        print(self.creating)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.creating = false
        
        return true
    }
    
//    @IBAction func cancelPressed(_ sender: UIButton) {
//        cancelTapAction?(self)
//    }
    
    
}
