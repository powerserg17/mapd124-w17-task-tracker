//
//  LoginVC.swift
//  TaskTracker
//  300907406
//  Created by Serhii Pianykh on 2017-02-12.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//
//  ViewController for login and signing up with Firebase

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var signInUpBtn: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    //if user logged in - proceed
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "ListVC", sender: nil)
            }
        }
    }
    
    //sign in or sign up with firebase by email/pass
    //alert on empty fields
    @IBAction func signInUpPressed(_ sender: UIButton) {
        if !emailField.text!.isEmpty && !passwordField.text!.isEmpty {
            switch (sender.titleLabel!.text!) {
                case "Sign In":
                    self.login(email: emailField.text!, password: passwordField.text!)
                    break;
                case "Sign Up":
                    FIRAuth.auth()!.createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                        if error == nil {
                            self.login(email: self.emailField.text!, password: self.passwordField.text!)
                        }
                    }
                    break;
                default:
                    break;
            }
        } else {
            showAlert(alertTitle: "Error!", alertMessage: "You have left empty fields!")
        }
    }
    
    //login to FB with email and pass
    func login(email: String, password: String) {
        FIRAuth.auth()!.signIn(withEmail: email,
                               password: password) {user, error in
                                if error != nil {
                                    self.showAlert(alertTitle: "Error!", alertMessage: "Invalid Credentials!")
                                }
        }
    }
    
    //func for showing alert with passed title and message
    func showAlert(alertTitle: String, alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okButton)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //clear textfields
    func clearFields() {
        self.emailField.text = ""
        self.passwordField.text = ""
    }

    //change button title
    @IBAction func createAccount(_ sender: UIButton) {
        signInUpBtn.setTitle("Sign Up", for: .normal)
        sender.isHidden = true
    }
}
