//
//  IngredientItem.swift
//  RecipeBook
//
//  Created by Brandon Evans on 3/17/15.
//  Copyright (c) 2015 Vicinity inc. All rights reserved.
//

import Foundation

class IngredientItem: NSObject, NSCoding {
    
    var name: String = ""
    var amount: String = ""
    var units: String = ""
    
    required init(coder aDecoder: NSCoder) {
        
        name = aDecoder.decodeObjectForKey("Name") as String
        amount = aDecoder.decodeObjectForKey("Amount") as String
        units = aDecoder.decodeObjectForKey("Units") as String
        super.init()
    }
    
    override init() {
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(amount, forKey: "Amount")
        aCoder.encodeObject(units, forKey: "Units")
        
    }
    
}