//
//  RecipeListViewController.swift
//  RecipeBook
//
//  Created by Brandon Evans on 3/18/15.
//  Copyright (c) 2015 Vicinity inc. All rights reserved.
//

import UIKit

class RecipeListViewController: UITableViewController {

    var recipeList: [RecipeItem]
    
    required init(coder aDecoder: NSCoder) {
        
        recipeList = [RecipeItem]()
        super.init(coder: aDecoder)
        
        var recipe = RecipeItem(name: "Mac N Cheese")
        recipeList.append(recipe)
       
        recipe = RecipeItem(name: "Pizza")
        recipeList.append(recipe)
        
        recipe = RecipeItem(name: "Rice")
        recipeList.append(recipe)
        
        recipe = RecipeItem(name: "Cookie")
        recipeList.append(recipe)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recipeList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RecipeCell"
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        
        if cell == nil {
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        let recipe = recipeList[indexPath.row]
        cell.textLabel?.text = "RecipeName"
        cell.detailTextLabel?.text = "Difficulty"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let recipe = recipeList[indexPath.row]
        let segueIdentifier = "ShowRecipe"
        
        // First step towards sending the recipe object to the next view controller, so it knows which recipe to access
        performSegueWithIdentifier(segueIdentifier, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Second step towards sending the recipe object to the next view controller, so it knows which recipe to access
        if segue.identifier == "ShowRecipe" {
            
            let controller = segue.destinationViewController as RecipeViewController
            
            controller.recipe = sender as RecipeItem
        }
    }
    
    
    
    
    
}
