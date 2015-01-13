//
//  RestTemplate.swift
//  PetPal
//
//  Created by Haavar Valeur on 12/30/14.
//  Copyright (c) 2014 PetPal. All rights reserved.
//

import Foundation
class RestTemplate: NSObject {
    
    func get(url: String, handler: (body: NSDictionary, statusCode: Int, error: NSError?) -> Void)  {
        service(url, method: "GET", body: nil, handler: handler)
    }

    
    func post(url: String, body: NSDictionary, handler: (body: NSDictionary, statusCode: Int, error: NSError?) -> Void)  {
        service(url, method: "POST", body: body, handler: handler)
    }
    
    func service(url: String, method: String, body: NSDictionary?, handler: (body: NSDictionary, statusCode: Int, error: NSError?) -> Void)  {
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 60)
        var response: NSURLResponse?
        var jsonError: NSError?
        
        if (body != nil) {
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body!, options: NSJSONWritingOptions(0), error: &jsonError)
            request.HTTPMethod =  method
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, asyncError) in
            // println(NSString(data: data, encoding: NSUTF8StringEncoding))
            if (asyncError != nil) {
                //  println("A non-nill error Occurred: \(asyncError)")
                handler(body: NSDictionary(), statusCode: -1, error: asyncError)
                
            } else if let httpResponse = response as? NSHTTPURLResponse {
                let jsonResponse: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonError)
                handler(body: jsonResponse as NSDictionary, statusCode: httpResponse.statusCode, error: nil)
            } else {
                // can this ever happen????
                handler(body: NSDictionary(), statusCode: -1, error: nil)
            }
        }
    }

}