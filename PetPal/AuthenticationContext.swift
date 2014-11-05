//
//  AuthenticationContext.swift
//  PetPal
//
//  Created by Haavar Valeur on 10/20/14.
//  Copyright (c) 2014 PetPal. All rights reserved.
//

import Foundation

var AUTH_ERROR_DOMAIN = "AuthErrorDomain"

class AuthenticationContext {
    var authToken: String = ""
    var emailAddress: String = ""
  
    func logout() {
        emailAddress = ""
        authToken = ""
    }
    
    /*
curl -v -X POST https://authpetpalci.herokuapp.com/user/auth -H "Content-Type: application/json" -H "Accept: application/json" -d '{"user":{"email":"haavar@gmail.com", "password":"secret11"}}'
*/
    func authenticate(username: String, password: String, handler: (error: NSError?) -> Void) {
        var url = "https://authpetpalci.herokuapp.com/user/auth"
        var user = NSMutableDictionary()
        user.setValue(username, forKey: "email")
        user.setValue(password, forKey: "password")
        var postData =  NSMutableDictionary()
        postData.setValue(user, forKey: "user")
        
        var body: NSDictionary?
        var statusCode: Int?
        post(url, body: postData, handler: {(responseBody, statusCode, postError) in
            if (postError != nil) {
                handler(error: postError)
            } else {
                println("statusCode=\(statusCode)")
                if (statusCode == 200) {
                    self.authToken = responseBody.valueForKey("authentication_token") as String
                    self.emailAddress = responseBody.valueForKey("email") as String
                    println("token= \(self.authToken)")
                    handler(error: nil)
                } else {
                    handler(error: NSError(domain: AUTH_ERROR_DOMAIN, code: -1, userInfo: nil))
                }
            }
        })
    }
    

    
    /*
    curl -v -X POST https://authpetpalci.herokuapp.com/user -H "Content-Type: application/json" -d '{"user":{"email":"haavar@gmail.com", "password":"Test1234", "password_confirmation":"Test1234"}}'
*/
    func createUser(username: String, password: String, handler: (error: NSError?) -> Void) {
        println("creating \(username) with password \(password)")
        var url = "https://authpetpalci.herokuapp.com/user"
        var user = NSMutableDictionary()
        user.setValue(username, forKey: "email")
        user.setValue(password, forKey: "password")
        user.setValue(password, forKey: "password_confirmation")
        var postData =  NSMutableDictionary()
        postData.setValue(user, forKey: "user")
        
        post(url, body: postData, handler: {(body, statusCode, postError) in
            
            if (postError != nil) {
                handler(error: postError)
            } else {
                println("user created")
                if (statusCode == 200) {
                    handler(error: nil)
                } else {
                    handler(error: NSError(domain: AUTH_ERROR_DOMAIN, code: -1, userInfo: nil))
 
                }
            }
        })
    }
    
    
    
    func post(url: String, body: NSDictionary, handler: (body: NSDictionary, statusCode: Int, error: NSError?) -> Void)  {
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 60)
        var response: NSURLResponse?
        var jsonError: NSError?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions(0), error: &jsonError)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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