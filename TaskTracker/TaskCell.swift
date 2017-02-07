//
//  TaskCell.swift
//  TaskTracker
//
//  Created by Serhii Pianykh on 2017-01-31.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    let imgChecked = UIImage(named: "checkbox-checked")
    let imgUnchecked = UIImage(named: "checkbox-unchecked")

    @IBOutlet var taskLabel: UILabel!
    
    
    @IBOutlet weak var doneBtn: UIButton!
    
    var doneTapAction: ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(task: Task) {
        taskLabel.text = task.title
        if (task.done) {
            doneBtn.setImage(imgChecked, for: UIControlState.normal)
        } else {
            doneBtn.setImage(imgUnchecked, for: UIControlState.normal)
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
    
    
    

    
}
