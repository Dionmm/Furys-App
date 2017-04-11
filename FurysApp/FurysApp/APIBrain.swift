//
//  APIBrain.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 25/03/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import Foundation
import Security

class APIBrain {
    var url = "https://api.furysayr.co.uk"
    
    private let grantType = "password" //For ASP Identity when logging in
    
    private func createURL(to appendage: String) -> URL{
        return URL(string: url + appendage)!
    }
    
    //Creates encode in following format. Does not accept arrays atm: name=value&foo=bar
    private func createURLEncode(of dictionary: Dictionary<String, String>) -> String{
        var encodedString = ""
        for (name, value) in dictionary{
            encodedString = encodedString + name + "=" + value + "&"
        }
        //Remove the final '&' as it's unnecessary. Does not harm to leave it in, just prettifying
        encodedString.remove(at: encodedString.index(before: encodedString.endIndex))
        return encodedString
    }
    
    private func createRequest(type: String, to url: URL, with data: String, callback: @escaping (Data, Int) -> ()){
        var request = URLRequest(url: url)
        
        //Set request parameters
        request.allowsCellularAccess = true
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = type
        request.httpBody = data.data(using: String.Encoding.ascii, allowLossyConversion: false)
        
        if(userLoggedIn){
            request.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }
        
        //Send request and process response
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request){
            data, response, error in
            if error != nil{
                print(error!.localizedDescription)
            } else{
                if let status = response as? HTTPURLResponse{
                    print(status.statusCode)
                    if status.statusCode < 500 {
                        callback(data!, status.statusCode)
                    } else{
                        print("Something went wrong, please try again")
                        callback(data!, status.statusCode)
                    }
                }
            }
        }
        task.resume()
    }
    
    var userLoggedIn: Bool {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "username") != nil{
            let expiryDate = defaults.double(forKey: "tokenExpiryDate")
            let currentDate = Double(Date().timeIntervalSinceReferenceDate)
            
            //Get the expiry date in seconds since 1 Jan 2001 and compare with current date
            //in seconds from 1 Jan 2001, if < 45,000 (~12 hours) then consider token expired
            if(expiryDate - currentDate > 45000){
                authToken = defaults.string(forKey: "authToken")!
                return true
            } else{
                //Delete all saved user data and force relogin
                defaults.removeObject(forKey: "username")
                defaults.removeObject(forKey: "authToken")
                defaults.removeObject(forKey: "tokenExpiryDate")
            }
        }
        return false
    }
    
    
    var authToken = ""
    
    
    func loginUser(username: String, password: String, callback: @escaping (Dictionary<String, Any>, Int) -> ()){
        let loginURL = createURL(to: "/token")
        let loginDictionary = [
            "grant_type": grantType,
            "username": username,
            "password": password
        ]
        let requestBody = createURLEncode(of: loginDictionary)
        
        createRequest(type: "POST", to: loginURL, with: requestBody){data, responseCode in
            
            do{
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]{
                    print("JSON decode succeeded")
                    //Check for success and auth token then save authtoken to user defaults
                    if let authToken = json["access_token"] {
                        
                        
                        let expiryDate = self.CalculateExpiryDate(with: (json["expires_in"] as! Double?)!)
                        
                        
                        let defaults = UserDefaults.standard
                        defaults.set(authToken, forKey: "authToken")
                        defaults.set(json["userName"], forKey: "username")
                        defaults.set(expiryDate, forKey: "tokenExpiryDate")
                    }
                    callback(json, responseCode)
                } else {
                    print("No JSON")
                    
                    callback(["error": "Problem decoding JSON"], responseCode)
                }
            } catch{
                print("JSON decode failed")
                callback(["error": "Problem decoding JSON"], responseCode)
            }
        }
    }
    
    func CalculateExpiryDate(with expiryTime: Double) -> Double{
        let currentDate = Date()
        print(currentDate)
        let currentDateInSeconds = Double(currentDate.timeIntervalSinceReferenceDate)
        
        return currentDateInSeconds + expiryTime
        
    }
    
    
    func registerUser(username: String, password: String, email: String, callback: @escaping (Dictionary<String, Any>, Int) -> ()){
        let registerURL = createURL(to: "/user/register")
        let registerDictionary = [
            "username" : username,
            "password" : password,
            "confirmPassword" : password,//Password should be confirmed before being passed to here
            "email" : email
        ]
        
        let requestBody = createURLEncode(of: registerDictionary)
        
        createRequest(type: "POST", to: registerURL, with: requestBody){data, responseCode in
            do{
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]{
                    print("JSON decode succeeded")
                    callback(json, responseCode)
                } else {
                    print("No JSON")
                    
                    callback(["error": "Problem decoding JSON"], responseCode)
                }
            } catch{
                print("JSON decode failed")
                callback(["error": "Problem decoding JSON"], responseCode)
            }
            
        }
        
    }

    func getDrinks(beverageType: String?, callback: @escaping (Dictionary<String, Any>, Int) -> ()){
        //Swift didn't like doing an If else here with drinksURL, investigate later
        var drinksURL = createURL(to: "/drink")
        if beverageType != nil{
            drinksURL = createURL(to: "/drink?beverageType=\(beverageType!)")
        }
    
        print(drinksURL)
        
        createRequest(type: "GET", to: drinksURL, with: ""){ data, responseCode in
            do{
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Array<Any>{
                    print("JSON decode succeeded")
                    
                    print(json)
                    
                    
                    //callback(json, responseCode)
                } else {
                    print("No JSON")
                    
                    callback(["error": "Problem decoding JSON"], responseCode)
                }
            } catch{
                print("JSON decode failed")
                callback(["error": "Problem decoding JSON"], responseCode)
            }
        }
    }
}
