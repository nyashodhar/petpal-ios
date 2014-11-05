//
//  SiginUpViewController.swift
//  PetPal
//
//  Created by Haavar Valeur on 10/13/14.
//  Copyright (c) 2014 PetPal. All rights reserved.
//

import UIKit

class SiginUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var scrollView: UICollectionView!

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    var keyboardControl: KeyboardControl!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardControl = KeyboardControl(scrollView: scrollView, textFields: [usernameField, passwordField, repeatPasswordField])
        usernameField.delegate = self
        passwordField.delegate = self
        repeatPasswordField.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        keyboardControl.activate()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        keyboardControl.deavtivate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        if (textField == usernameField) {
            passwordField.becomeFirstResponder()
        } else if(textField == passwordField) {
            repeatPasswordField.becomeFirstResponder()
        } else if (textField == repeatPasswordField) {
            signUpClicked(self)
        }
        return true
    }
    
    @IBAction func signUpClicked(sender: AnyObject) {
        var username = usernameField.text
        var password = passwordField.text
        
        
        if (username == "") {
            showError("Please enter a username")
            return
        }
        if (password == "") {
            showError("Please enter a password")
            return
        }
        if (password != repeatPasswordField.text) {
            showError("The passwords did not match")
            return
        }
        appContext.authContext.createUser(username, password: password, {(error: NSError?) in
            if (error != nil) {
                if (error?.domain == AUTH_ERROR_DOMAIN) {
                    // todo check if it's a create error
                    self.showError("User already exists. Please log in")
                } else {
                    self.showError("Unable to create user")
                }
            } else {
                appContext.authContext.authenticate(username, password: password, {(error) in
                    if (error != nil) {
                        self.performSegueWithIdentifier("go_home", sender: self)
                    } else {
                        self.showError("Unable to log in newly created user") // todo: should never happen...
                    }
                })
            }
        })

        
        
    }
    
    func showError(message: String) {
        var alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
