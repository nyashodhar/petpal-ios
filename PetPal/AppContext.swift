//
//  AppContext.swift
//  PetPal
//
//  Created by Haavar Valeur on 10/24/14.
//  Copyright (c) 2014 PetPal. All rights reserved.
//

import Foundation

let appContext: AppContext = { AppContext() }()

class AppContext : NSObject {
    var authContext: AuthenticationContext
    var bluetoothContext: BluetoothContext
    
    class func instance() -> AppContext {
        return appContext
    }
    
    override init() {
        self.authContext = AuthenticationContext()
        self.bluetoothContext = BluetoothContext()
    }
    
}
