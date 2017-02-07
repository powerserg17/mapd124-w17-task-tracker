//
//  CardView.swift
//  TaskTracker
//
//  Created by Serhii Pianykh on 2017-02-05.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit

private var card = false

extension UIView {
    
    @IBInspectable var cardView: Bool {
        get {
            return card
        }
        
        set {
            card = newValue
            
            if card {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor.init(red: 157/255, green: 157/255, blue: 157/255, alpha: 0.5).cgColor
            } else {
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
    }
}
