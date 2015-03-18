//
//  RecipeViewController.swift
//  RecipeBook
//
//  Created by Brandon Evans on 3/17/15.
//  Copyright (c) 2015 Vicinity inc. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController, IngredientDetailViewControllerDelegate {
    
    var ingredients: [IngredientItem]

    required init(coder aDecoder: NSCoder) {
        
        ingredients = [IngredientItem]()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Recipe"
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
        
        configureCellLabels(cell, withIngredientItem: ingredient)
        
        return cell
    }
    
    // Swipe to delete method
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        ingredients.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let navigationController = segue.destinationViewController as UINavigationController
        let controller = navigationController.topViewController as IngredientDetailViewController
        
        controller.delegate = self
        
        if segue.identifier == "AddIngredient" {
            
        } else if segue.identifier == "EditIngredient" {
            
            if let indexPath = tableView.indexPathForCell(sender as UITableViewCell) {
                controller.ingredientToEdit = ingredients[indexPath.row]
            }
        }
    }
    
    func configureCellLabels(cell: UITableViewCell, withIngredientItem ingredient: IngredientItem) {
        
        let amount = ingredient.amount
        let units = ingredient.units
        let amountUnitsString = "\(amount) \(units)"
        
        cell.textLabel?.text = ingredient.name
        cell.detailTextLabel?.text = amountUnitsString
    }
    
    func ingredientDetailViewControllerDidCancel(controller: IngredientDetailViewController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func ingredientDetailViewController(controller: IngredientDetailViewController, didFinishAddingIngredient ingredient: IngredientItem) {
        
        let newRowIndex = ingredients.count
        
        ingredients.append(ingredient)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func ingredientDetailViewController(controller: IngredientDetailViewController, didFinishEditingIngredient ingredient: IngredientItem) {
        
        let name = ingredient.name
        let amount = ingredient.amount
        let units = ingredient.units
        
        var index = 0
        
        for item in ingredients {
            
            var counter = 0
            
            let itemName = item.name
            let itemAmount = item.amount
            let itemUnits = item.units
            
            if itemName == name && itemAmount == amount && itemUnits == units {
                
                index = counter
                
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                
                if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                    
                    configureCellLabels(cell, withIngredientItem: ingredient)
                }
            }
            counter += 1
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}
