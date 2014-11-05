//
//  LoginViewController.swift
//  PetPal
//
//  Created by Haavar Valeur on 10/13/14.
//  Copyright (c) 2014 PetPal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UICollectionView!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var keyboardControl: KeyboardControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        passwordField.delegate = self
        keyboardControl = KeyboardControl(scrollView: scrollView, textFields: [usernameField, passwordField])
        
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
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        if (textField == usernameField) {
            passwordField.becomeFirstResponder()
        } else if (textField == passwordField) {
            loginClicked(self)
        }
        return true
    }
    
    @IBAction func loginClicked(sender: AnyObject) {
        var username = usernameField.text
        var password = passwordField.text
        if (username == "") {
            showError("Please enter a valid username")
            return
        }
        if (password == "") {
            showError("Pleae enter your password")
            return
        }
        println("Logging in \(username) with password \(password)")
        appContext.authContext.authenticate(username, password: password, {(error: NSError?) in
            if (error != nil) {
                // todo check if app or io error
                if (error?.domain == AUTH_ERROR_DOMAIN) {
                    self.showError("Invalid username or password")
                } else {
                    self.showError("Unable to log in")
                }
            } else {
                self.performSegueWithIdentifier("go_home", sender: self)
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
