//
//  IngredientDetailViewController.swift
//  RecipeBook
//
//  Created by Brandon Evans on 3/17/15.
//  Copyright (c) 2015 Vicinity inc. All rights reserved.
//

import UIKit

protocol ingredientDetailViewControllerDelegate: class {
    
    func ingredientDetailViewControllerDidCancel(controller: IngredientDetailViewController)
    func ingredientDetailViewController(controller: IngredientDetailViewController,
        didFinishAddingIngredient ingredient: IngredientItem)
    func ingredientDetailViewController(controller: IngredientDetailViewController,
        didFinishEditingIngredient ingredient: IngredientItem)
}

class IngredientDetailViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: ingredientDetailViewControllerDelegate?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var unitsTextField: UITextField!
    
    @IBAction func done() {
        
        let ingredient = IngredientItem()
        ingredient.name = nameTextField.text
        ingredient.amount = amountTextField.text
        ingredient.units = unitsTextField.text
        delegate?.ingredientDetailViewController(self, didFinishAddingIngredient: ingredient)
    }
    
    @IBAction func cancel() {
        
        delegate?.ingredientDetailViewControllerDidCancel(self)
    }
    
    override func viewDidLoad() {
        tableView.rowHeight = 44
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        // Makes the cells unselectable (they should already be via the interface builder, but this adds security)
        return nil
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // This will enable or disable the done button accordingly as to whether or not text has been entered in each of the text fields
        let oldNameText: NSString = nameTextField.text
        let oldAmountText: NSString = amountTextField.text
        let oldUnitsText: NSString = unitsTextField.text
        
        let newNameText: NSString = oldNameText.stringByReplacingCharactersInRange(range, withString: string)
        let newAmountText: NSString = oldAmountText.stringByReplacingCharactersInRange(range, withString: string)
        let newUnitsText: NSString = oldUnitsText.stringByReplacingCharactersInRange(range, withString: string)
        
        if newNameText.length > 0 && newAmountText.length > 0 && newUnitsText.length > 0 {
            doneBarButton.enabled = true
        } else {
            doneBarButton.enabled = false
        }
        
        return true
    }
}
