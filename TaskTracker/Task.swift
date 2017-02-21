//
//  Task.swift
//  TaskTracker
//  300907406
//  Created by Serhii Pianykh on 2017-01-31.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//
//  Model class for task

import Foundation

class Task {
    private var _title: String!
    private var _details: String?
    private var _done: Bool!
    private var _ref: FIRDatabaseReference?
    private var _creating: Bool!
    
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
    
    var ref: FIRDatabaseReference? {
        get {
            return _ref
        }
        set {
            _ref = newValue
        }
    }
    
    var creating: Bool {
        get {
            return _creating
        }
        set {
            _creating = newValue
        }
    }
    
    init(title: String) {
        _title = title
        _done = false
        _creating = true
    }
    
    //creating task from snapshot taken from FBDB
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        _title = snapshotValue["title"] as! String
        _details = (snapshotValue["details"] as! String)
        _done = snapshotValue["done"] as! Bool
        _ref = snapshot.ref
        _creating = snapshotValue["creating"] as! Bool
    }
    
    func toAnyObject() -> Any {
        return [
            "title": title,
            "details": details ?? "",
            "done": done,
            "creating": creating
        ]
    }
    
    
}
