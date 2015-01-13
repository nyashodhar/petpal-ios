//
//  SerializableTest.swift
//  PetPal
//
//  Created by Haavar Valeur on 12/30/14.
//  Copyright (c) 2014 PetPal. All rights reserved.
//

import XCTest
import PetPal

class Car: Serializable {
    var model : String = ""
    var make : String = ""
}

class SerializableTest: XCTestCase {
    func testDeserialize() {
        var dict = NSMutableDictionary()
        dict.setValue("Jeep", forKey: "make")
        dict.setValue("Cherokee", forKey: "model")
        
        let car = Car() 
        car.setValuesForKeysWithDictionary(dict)

        XCTAssertEqual("Jeep", car.make)
        XCTAssertEqual("Cherokee", car.model)
    }
    
    func testSerialize() {
        let car = Car()
        car.make = "Porsche"
        car.model = "Cayenne"
        var data:NSData = car.toJson();
        let string: String = NSString(data: data, encoding: NSUTF8StringEncoding)!
        XCTAssertEqual("{\"model\":\"Cayenne\",\"make\":\"Porsche\"}", string)
    }
}
