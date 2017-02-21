//
//  RoundedButton.swift
//  TaskTracker
//  300907406
//  Created by Serhii Pianykh on 2017-02-06.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//
//  Extension for UIButton class to make it rounded

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
