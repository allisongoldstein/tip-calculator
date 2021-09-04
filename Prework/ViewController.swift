//
//  ViewController.swift
//  Prework
//
//  Created by Allison Goldstein on 9/3/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipDisplay: UILabel!
    @IBOutlet var splitSwitch: UIView!
    @IBOutlet weak var splitNumber: UISegmentedControl!
    @IBOutlet weak var perPersonText: UILabel!
    @IBOutlet weak var perPersonTip: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billAmountTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.billAmountTextField.resignFirstResponder()
    }
    
    var userInput = Double(0)
    var tip = Double(0)
    var percentSelected = false
    var splitSelected = false
    
    @IBAction func updateTotalBill(_ sender: Any) {
        if percentSelected {
            calculateTip(UITextField.self)
        }
        
        userInput = Double(billAmountTextField.text!) ?? 0
        billAmountTextField.text = String(format: "$%.2f", userInput)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        self.billAmountTextField.resignFirstResponder()
        
        // Round slider value
        let sliderPercent = Double(round(tipSlider.value))
        // Update percentage display
        tipDisplay.text = String(Int(sliderPercent)) + "%"
        
        // Get bill amount
        let bill = userInput
        
        // Get Total tip by multiplying tip * tipPercentage
        let tipPercentage = sliderPercent / 100
        tip = bill * tipPercentage
        let total = bill + tip
        
        // Update Tip Amount Label
        tipAmountLabel.text = String(format: "$%.2f", tip)
        // Update Total Amount
        totalLabel.text = String(format: "$%.2f", total)
        
        if isSplit && splitSelected {
            calculateSplit(UISlider.self)
        }
    }

    @IBAction func changeSegment(_ sender: Any) {
        percentSelected = true
        
        // Set tip slider
        let segmentValues = [15, 18, 20]
        tipSlider.value = Float(segmentValues[tipControl.selectedSegmentIndex])
        
        // Call calculate
        calculateTip(UISegmentedControl.self)
    }
    
    var isSplit = false
    
    @IBAction func splitTip(_ sender: Any) {
        if isSplit {
            isSplit = false
            splitNumber.isEnabled = false
            perPersonText.isEnabled = false
            perPersonTip.isEnabled = false
        } else {
            isSplit = true
            splitNumber.isEnabled = true
            perPersonText.isEnabled = true
            perPersonTip.isEnabled = true
            
            if splitSelected {
                calculateSplit(UIView.self)
            }
        }
    }
    
    @IBAction func calculateSplit(_ sender: Any) {
        splitSelected = true
        
        // Calculate tip per person
        let splitOptions = [2, 3, 4]
        let perEachTip = tip / Double(splitOptions[splitNumber.selectedSegmentIndex])
        
        // Update per person text
        perPersonTip.text = String(format: "$%.2f", perEachTip)
        
    }
    
    
}





