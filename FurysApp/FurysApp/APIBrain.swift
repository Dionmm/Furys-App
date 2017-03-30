//
//  APIBrain.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 25/03/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import Foundation

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
    
    private func createRequest(type: String, to url: URL, with data: String, callback: @escaping (Dictionary<String, Any>, Int) -> ()){
        var request = URLRequest(url: url)
        
        //Set request parameters
        request.allowsCellularAccess = true
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = type
        request.httpBody = data.data(using: String.Encoding.ascii, allowLossyConversion: false)
        
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
                        do{
                            if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                                print("JSON decode succeeded")
                                callback(json, status.statusCode)
                            } else {
                                print("No Json")
                            }
                        } catch{
                            print("JSON decode failed")
                        }
                    } else{
                        print("Something went wrong, please try again")
                        callback(["error": "Server error occurred"], status.statusCode)
                    }
                }
            }
        }
        task.resume()
    }
    
    func loginUser(username: String, password: String, callback: @escaping (Dictionary<String, Any>, Int) -> ()){
        let loginURL = createURL(to: "/token")
        let loginDictionary = [
            "grant_type": grantType,
            "username": username,
            "password": password
        ]
        let requestBody = createURLEncode(of: loginDictionary)
        
        createRequest(type: "POST", to: loginURL, with: requestBody){data, responseCode in
            //Check for success and auth token then save authtoken to user defaults
            if let authToken = data["access_token"] {
                let defaults = UserDefaults.standard
                defaults.set(authToken, forKey: "authToken")
                defaults.set(data["userName"], forKey: "Username")
            }
            callback(data, responseCode)
            
        }
        
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
            callback(data, responseCode)
            
        }
        
    }
}
