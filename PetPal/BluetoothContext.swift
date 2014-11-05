//
//  BluetoothContext.swift
//  PetPal
//
//  Created by Haavar Valeur on 10/21/14.
//  Copyright (c) 2014 PetPal. All rights reserved.
//

import Foundation
import CoreBluetooth

class BluetoothContext: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager : CBCentralManager!
    var discoveredPeripheral: CBPeripheral!
    
    func scan() {
        centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
        println("created bluetooth context")
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager!)  {
        println("CBCentralManager state change state=\(central.state)")
        
        if (central.state != CBCentralManagerState.PoweredOn) {
            return;
        }
        if (central.state == CBCentralManagerState.PoweredOn) {
            // [centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:BLUETOOTH_LISTEN_SERVICE]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
            
            centralManager.scanForPeripheralsWithServices(nil, options:nil)
            println("Scranning for all services");
        }
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        
        println("Discovered \(peripheral.name) with data \(advertisementData)")
        
        if (peripheral.services != nil) {
            for service in peripheral.services {
                println("Service description=\(service.description)")
            }
        }
        
        if (discoveredPeripheral != peripheral) {
            // Save a local copy of the peripheral, so CoreBluetooth doesn't get rid of it
            self.discoveredPeripheral = peripheral
            // And connect
            println("Connecting to peripheral \(peripheral)")
            centralManager.connectPeripheral(peripheral, options: nil)
        }
        
        
    }
    
    func centralManager(central: CBCentralManager!, didFailToConnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        println("Failed to connect")
    }
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        println("Connected to \(peripheral)")
        
        peripheral.delegate = self
        // [peripheral discoverServices:@[[CBUUID UUIDWithString:BLUETOOTH_LISTEN_SERVICE]]];
        
        peripheral.discoverServices(nil)
    }
    
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        println("discovered services error=\(error)")
        if (error != nil) {
            println("error discovering services (probably not)")
            //        [self cleanup];
            return;
        }
        for service in peripheral.services {
            //[peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]] forService:service];
            println("Got service description=\(service.description) uuid=\(service.UUID)")
            peripheral.discoverCharacteristics(nil, forService:service as CBService)
            
        }
        // Discover other characteristics
    }
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
        if (error != nil) {
            println("error discoverCharacteristicsForService services (maybe...)");
            //   [self cleanup];
            return;
        }
        for characteristic in service.characteristics {
            // if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
            //     [peripheral writeValue:<#(NSData *)#> forCharacteristic:<#(CBCharacteristic *)#> type:<#(CBCharacteristicWriteType)#>]
            ///     [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            // }
            println("characteristic uuid=\(characteristic.UUID)")
        }
    }
    
    
    
}