//
//  Drink.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 12/04/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import Foundation

struct Drink: Equatable {
    var id: String
    var name: String
    var price: Double
    var beverageType: String
    
    static func == (lhs: Drink, rhs: Drink) -> Bool{
        return lhs.id == rhs.id
    }
}
