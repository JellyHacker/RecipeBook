//
//  IngredientDetailViewController.swift
//  RecipeBook
//
//  Created by Brandon Evans on 3/17/15.
//  Copyright (c) 2015 Vicinity inc. All rights reserved.
//

import UIKit

class IngredientDetailViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var unitsTextField: UITextField!
    
    @IBAction func done() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 0
    }

}
