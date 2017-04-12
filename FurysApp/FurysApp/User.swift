//
//  User.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 12/04/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import Foundation

class User{
    
    var username: String?
    var authToken: String?
    var role: Roles = .customer
    var hasBasket: Bool = false
    
    var firstName: String?
    var lastName: String?
    
    enum Roles{
        case customer
        case admin
    }
    
}
