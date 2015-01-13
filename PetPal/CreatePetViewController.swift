//
//  CreatePetViewController.swift
//  PetPal
//
//  Created by Haavar Valeur on 12/22/14.
//  Copyright (c) 2014 PetPal. All rights reserved.
//

import UIKit

class CreatePetViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var petNameTextField: UITextField!

    
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var catButton: UIButton!
   
    @IBOutlet weak var deviceStatusLabel: UILabel!
    
    @IBOutlet weak var deviceDetectedView: UIScrollView!
    

    @IBOutlet weak var pinField1: UITextField!

    @IBOutlet weak var pinField2: UITextField!
    
    @IBOutlet weak var pinField3: UITextField!
    @IBOutlet weak var pinField4: UITextField!
    
    @IBOutlet weak var pinField5: UITextField!


    @IBOutlet weak var pinField6: UITextField!
    
    
    var pinFields: [UITextField]?

    override func viewDidLoad() {
        super.viewDidLoad();
        addLeftLabelToTextField("Pet Name:", textField: petNameTextField)
        
        var image = UIImage(named: "ic_done_black_24dp")
        
        catButton.layer.borderWidth = 1
        catButton.layer.borderColor = UIColor.blackColor().CGColor
        catButton.setImage(image, forState:UIControlState.Selected)
      
        dogButton.layer.borderWidth = 1
        dogButton.layer.borderColor = UIColor.blackColor().CGColor
        dogButton.setImage(image, forState:UIControlState.Selected)
        deviceDetectedView.hidden = true
        deviceStatusLabel.text = "Not found"
        
        pinFields = [pinField1, pinField2, pinField3, pinField4, pinField5, pinField6]
        for field in pinFields! {
            field.delegate = self
        }
    }
    
    
    func addLeftLabelToTextField(var text: String, var textField: UITextField) {
        var leftView = UILabel()
        leftView.font = UIFont(name: "Helvetica-Bold", size: textField.font.pointSize)
        leftView.text =  "   " + text + " "
        leftView.sizeToFit()
        textField.leftView = leftView
        textField.leftViewMode = UITextFieldViewMode.Always
    }
    
    func foundDevice() {
        deviceStatusLabel.text = "Detected"
        deviceDetectedView.hidden = false
    }
    
    @IBAction func dogButtonClicked(sender: AnyObject) {
        if (dogButton.selected) {
            foundDevice();
        }
        catButton.selected = false
        dogButton.selected = true
    }
    
    @IBAction func catButtonClicked(sender: UIButton) {
        catButton.selected = true
        dogButton.selected = false
    }
    
    
    // control the pin input
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        textField.text = string
        for var i = 0; i < pinFields?.count ; ++i {
            if (textField == pinFields?[i] && i+1 < pinFields?.count) {
                pinFields?[i+1].becomeFirstResponder()
            }
        }
        return false
    }
}