//
//  RecipeViewController.swift
//  RecipeBook
//
//  Created by Brandon Evans on 3/17/15.
//  Copyright (c) 2015 Vicinity inc. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController {
    
    var ingredients: [IngredientItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Recipe"
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return ingredients.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell") as UITableViewCell
        let ingredient = ingredients[indexPath.row]
        let amount = ingredient.amount
        let units = ingredient.units
        let amountUnitsString = "\(amount) \(units)"
        
        cell.textLabel?.text = ingredient.name
        cell.detailTextLabel?.text = amountUnitsString
        
        return cell
    }

}
