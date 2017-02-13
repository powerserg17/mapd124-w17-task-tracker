//
//  LoginVC.swift
//  TaskTracker
//
//  Created by Serhii Pianykh on 2017-02-12.
//  Copyright © 2017 Serhii Pianykh. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var signInUpBtn: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "ListVC", sender: nil)
            }
        }
    }
    
    @IBAction func signInUpPressed(_ sender: UIButton) {
        if !emailField.text!.isEmpty && !emailField.text!.isEmpty {
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
    
    func login(email: String, password: String) {
        FIRAuth.auth()!.signIn(withEmail: email,
                               password: password) {user, error in
                                if error != nil {
                                    self.showAlert(alertTitle: "Error!", alertMessage: "Invalid Credentials!")
                                }
        }
    }
    
    
    func showAlert(alertTitle: String, alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okButton)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func clearFields() {
        self.emailField.text = ""
        self.passwordField.text = ""
    }

    
    @IBAction func createAccount(_ sender: UIButton) {
        signInUpBtn.setTitle("Sign Up", for: .normal)
        sender.isHidden = true
    }
}
