//
//  IngredientDetailViewController.swift
//  RecipeBook
//
//  Created by Brandon Evans on 3/17/15.
//  Copyright (c) 2015 Vicinity inc. All rights reserved.
//

import UIKit

protocol IngredientDetailViewControllerDelegate: class {
    
    func ingredientDetailViewControllerDidCancel(controller: IngredientDetailViewController)
    func ingredientDetailViewController(controller: IngredientDetailViewController,
        didFinishAddingIngredient ingredient: IngredientItem)
    func ingredientDetailViewController(controller: IngredientDetailViewController,
        didFinishEditingIngredient ingredient: IngredientItem)
}

class IngredientDetailViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: IngredientDetailViewControllerDelegate?
    var ingredientToEdit: IngredientItem?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var unitsTextField: UITextField!
    
    @IBAction func done() {
        
        var ingredient = IngredientItem()
        
        if let ingredient = ingredientToEdit {
            
            ingredient.name = nameTextField.text
            ingredient.amount = amountTextField.text
            ingredient.units = unitsTextField.text
            delegate?.ingredientDetailViewController(self, didFinishEditingIngredient: ingredient)
        } else {
            
            ingredient.name = nameTextField.text
            ingredient.amount = amountTextField.text
            ingredient.units = unitsTextField.text
            delegate?.ingredientDetailViewController(self, didFinishAddingIngredient: ingredient)
        }
        
    }
    
    @IBAction func cancel() {
    
        delegate?.ingredientDetailViewControllerDidCancel(self)
    }
    
    @IBAction func nextTextField() {
        
        if nameTextField.isFirstResponder() {
            
            amountTextField.becomeFirstResponder()
        } else if amountTextField.isFirstResponder() {
            
            unitsTextField.becomeFirstResponder()
        } else {
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.rowHeight = 44
        // Important in order to allow an existing ingredient to be edited
        if let ingredient = ingredientToEdit {
            title = "Edit Ingredient"
            nameTextField.text = ingredient.name
            amountTextField.text = ingredient.amount
            unitsTextField.text = ingredient.units
            doneBarButton.enabled = true    
        }
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
        
        var oldNameText: NSString = ""
        var newNameText: NSString = ""
        var oldAmountText: NSString = ""
        var newAmountText: NSString = ""
        var oldUnitsText: NSString = ""
        var newUnitsText: NSString = ""
        
        var nameLength: Int = 0
        var amountLength: Int = 0
        var unitsLength: Int = 0
        
        if textField == nameTextField {
            
            oldNameText = nameTextField.text
            newNameText = oldNameText.stringByReplacingCharactersInRange(range, withString: string)
        } else if textField == amountTextField {
            
            oldAmountText = amountTextField.text
            newAmountText = oldAmountText.stringByReplacingCharactersInRange(range, withString: string)
        } else if textField == unitsTextField {
        
            oldUnitsText = unitsTextField.text
            newUnitsText = oldUnitsText.stringByReplacingCharactersInRange(range, withString: string)
        } else {
        
        }
        
        let finalNameText: NSString = nameTextField.text
        let finalAmountText: NSString = amountTextField.text
        let finalUnitsText: NSString = unitsTextField.text
        
        nameLength = finalNameText.length
        amountLength = finalAmountText.length
        unitsLength = finalUnitsText.length

        if nameLength > 0 && amountLength > 0 && unitsLength > 0 {
            doneBarButton.enabled = true
        } else {
            doneBarButton.enabled = false
        }
        
        return true
    }
}
