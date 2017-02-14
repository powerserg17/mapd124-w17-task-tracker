//
//  CustomTitle.swift
//  TaskTracker
//
//  Created by Serhii Pianykh on 2017-02-14.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import Foundation
import UIKit

class CustomTitle: UIView {
    private var user: UILabel = UILabel()
    private var status: UILabel = UILabel()
    
    init(frame: CGRect, user: String, status: Bool) {
        super.init(frame: frame)
        initUserLabel(user: user)
        initStatusLabel(status: status)
        self.frame = CGRect(x:0, y:0, width:max(self.user.frame.size.width, self.status.frame.size.width), height:30)
        self.addSubview(self.user)
        self.addSubview(self.status)
        
        let widthDiff = self.status.frame.size.width - self.user.frame.size.width
        
        if widthDiff < 0 {
            let newX = widthDiff / 2
            self.status.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            self.user.frame.origin.x = newX
        }

    }
    
    func initUserLabel(user: String) {
        self.user = UILabel(frame: CGRect(x:0, y:-2, width:0, height:0))
        
        self.user.backgroundColor = UIColor.clear
        self.user.textColor = UIColor.init(colorLiteralRed: 244, green: 96, blue: 54, alpha: 1)
        self.user.font = UIFont.boldSystemFont(ofSize: 17)
        self.user.text = user
        self.user.sizeToFit()
    }
    
    func initStatusLabel(status: Bool) {
        self.status = UILabel(frame: CGRect(x:0, y:18, width:0, height:0))
        self.status.backgroundColor = UIColor.clear
        self.status.font = UIFont.systemFont(ofSize: 12)
        if status {
            self.status.textColor = UIColor.green
            self.status.text = "Online"
        } else {
            self.status.textColor = UIColor.red
            self.status.text = "Offline"
        }
        self.status.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
