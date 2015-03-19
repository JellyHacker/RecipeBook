//
//  RecipeItem.swift
//  RecipeBook
//
//  Created by Brandon Evans on 3/18/15.
//  Copyright (c) 2015 Vicinity inc. All rights reserved.
//

import UIKit

class RecipeItem: NSObject {
    
    var name: String = ""
    var ingredients = [IngredientItem]()
    
    init(name: String) {
        
        self.name = name
        super.init()
    }
}