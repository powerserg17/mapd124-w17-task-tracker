//
//  TaskCell.swift
//  TaskTracker
//
//  Created by Serhii Pianykh on 2017-01-31.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet var taskLabel: UILabel!
    
    @IBOutlet var doneSwitch: UISwitch!
    
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
            doneSwitch.isOn = true
        } else {
            doneSwitch.isOn = false
        }
    }

    @IBAction func doneChanged(_ sender: UISwitch) {
    }
}
