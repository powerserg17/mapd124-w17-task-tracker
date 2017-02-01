//
//  Task.swift
//  TaskTracker
//
//  Created by Serhii Pianykh on 2017-01-31.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import Foundation

class Task {
    private var _title: String!
    private var _details: String?
    private var _done: Bool!
    
    var title: String {
        get {
            return _title
        }
        
        set {
            _title = newValue
        }
    }
    
    var details: String? {
        get {
            return _details
        }
        
        set {
            _details = newValue
        }
    }
    
    var done: Bool {
        get {
            return _done
        }
        
        set {
            _done = newValue
        }
    }
    
    init(title: String) {
        _title = title
        _done = false
    }
    
    init(title: String, details: String) {
        _title = title
        _details = details
        _done = false
    }
    
    
}
