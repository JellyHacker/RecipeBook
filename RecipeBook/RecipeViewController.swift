//
//  RecipeViewController.swift
//  RecipeBook
//
//  Created by Brandon Evans on 3/17/15.
//  Copyright (c) 2015 Vicinity inc. All rights reserved.
//

import UIKit

class RecipeViewController: UITableViewController, IngredientDetailViewControllerDelegate {
    
    var recipe: RecipeItem!
    var ingredients: [IngredientItem]

    required init(coder aDecoder: NSCoder) {
        
        ingredients = [IngredientItem]()
        super.init(coder: aDecoder)
        title = recipe.name
        tableView.rowHeight = 44
        loadIngredients()
//println(documentsDirectory())
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
        saveIngredients()
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
        
        saveIngredients()
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
        
        saveIngredients()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*
    Load/Save functions --> Will move to DataModel.swift file (to be created)
    */
    func documentsDirectory() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        
        return paths[0]
    }
    
    func dataFilePath() -> String {
            
            return documentsDirectory().stringByAppendingPathComponent("RecipeBook.plist")
    }
    
    /*
    This method takes the contents of the items array and in two steps converts this to a block of binary data and then writes this data to a file:
    1. NSKeyedArchiver, which is a form of NSCoder that creates plist files, encodes the array and all the ChecklistItems in it into some sort of binary data format that can be written to a file.
    2. That data is placed in an NSMutableData object, which will write itself to the file specified by dataFilePath.
    */
    
    func saveIngredients() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        
        archiver.encodeObject(ingredients, forKey: "Ingredients")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadIngredients() {
            
            //println(documentsDirectory())
            
            // First you put the results of [self dataFilePath] in a temporary constant named path. You use the pathname more than once in this method so having it available in a local instead of calling dataFilePath() several times over is a small optimization.
            let path = dataFilePath()
            
            // Then you check whether the file actually exists and decide what happens based on that. If there is no Checklists.plist then there are obviously no ChecklistItem objects to load. This is what happens when the app is started up for the very first time. In that case, you’ll skip the rest of this method.
            if NSFileManager.defaultManager().fileExistsAtPath(path) {
                
                //When the app does find a Checklists.plist file, you’ll load the entire array and its contents from the file. This is essentially the reverse of saveChecklistItems(). First you load the contents of the file into an NSData object. Because this may fail, you put it in an if let statement. Then you create an NSKeyedUnarchiver object (note: this is an unarchiver) and ask it to decode that data into the items array. This populates the array with exact copies of the ChecklistItem objects that were frozen into this file.
                if let data = NSData(contentsOfFile: path) {
                
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                
                ingredients = unarchiver.decodeObjectForKey("Ingredients") as [IngredientItem]
                unarchiver.finishDecoding()
                //sortRecipes()
                }
                
            }
            
    }

    
    

}
