//
//  RoundedButton.swift
//  TaskTracker
//
//  Created by Serhii Pianykh on 2017-02-06.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit

private var rounded = false

extension UIButton {
    
    @IBInspectable var roundedButton : Bool {
        get {
            return rounded
        }
        
        set {
            rounded = newValue
            
            if rounded {
                self.layer.cornerRadius = 35.0
            } else {
                self.layer.cornerRadius = 0
            }
        }
    }
    
}
