//
//  DeviceViewController.swift
//  PetPal
//
//  Created by Haavar Valeur on 11/4/14.
//  Copyright (c) 2014 PetPal. All rights reserved.
//


import UIKit

class DeviceViewController: UIViewController {
    override func viewDidLoad() {
        appContext.bluetoothContext.scan()
    }
    
    
}