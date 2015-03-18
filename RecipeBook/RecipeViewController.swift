//
//  RecipeViewController.swift
//  RecipeBook
//
//  Created by Brandon Evans on 3/17/15.
//  Copyright (c) 2015 Vicinity inc. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController, IngredientDetailViewControllerDelegate {
    
    var ingredients: [IngredientItem] = []

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
        
        cell.textLabel?.text = ingredient.name
        cell.detailTextLabel?.text = amountUnitsString
        
        return cell
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
        
        dismissViewControllerAnimated(true, completion: nil)
    }

}
