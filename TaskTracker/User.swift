//
//  User.swift
//  TaskTracker
//  300907406
//  Created by Serhii Pianykh on 2017-02-12.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//
//  Model class for user

import Foundation

class User {
    
    private var _id: String
    private var _email: String
    
    var id: String {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var email: String {
        get {
            return _email
        }
        set {
            _email = newValue
        }
    }
    
    init(authData: FIRUser) {
        _id = authData.uid
        _email = authData.email!
    }
}
