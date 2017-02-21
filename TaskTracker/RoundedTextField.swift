//
//  RoundedTextField.swift
//  TaskTracker
//  300907406
//  Created by Serhii Pianykh on 2017-02-07.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//
//  Extension for UITextField class to make it rounded

import UIKit

private var rounded = false

extension UITextField{
    
    @IBInspectable var roundedTextField : Bool {
        get {
            return rounded
        }
        
        set {
            rounded = newValue
            
            if rounded {
                self.layer.cornerRadius = 10.0
            } else {
                self.layer.cornerRadius = 0
            }
        }
    }
    
}

