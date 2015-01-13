//
//  PetService.swift
//  PetPal
//
//  Created by Haavar Valeur on 12/30/14.
//  Copyright (c) 2014 PetPal. All rights reserved.
//

import Foundation

class PetService: NSObject {
    enum AnimalType {
        case cat
        case dog
    }
    
    class Pet {
        
    }
    
    var petServiceUrl: String = "http://127.0.0.1:3000"
    var restTemplate = RestTemplate()
    
    //curl -v -X GET http://127.0.0.1:3000/pet -H "Accept: application/json" -H "Content-Type: application/json" -H "X-User-Token: C5tZb5t6-ubJLs6K5yQ4"
    
    
    
    
    //curl -v -X GET http://127.0.0.1:3000/breed/creature/0?locale=en -H "Accept: application/json" -H "Content-Type: application/json"
    //curl -v -X GET http://127.0.0.1:3000/breed/creature/1?locale=en -H "Accept: application/json" -H "Content-Type: application/json"
    
    func getBreeds(animalType: AnimalType) {
        var url = petServiceUrl + "/breed/creature/" + (animalType == AnimalType.dog ? "1" : "0") + "/locale=en"
        restTemplate.get(url, handler: { (body, statusCode, error) -> Void in
            //code
            
        })
    }
    
    

    
}