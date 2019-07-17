//
//  ViewController.swift
//  Currency Convert
//
//  Created by Joel Groomer on 7/16/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyLabel: UILabel!
    @IBOutlet weak var cadButton: UIButton!
    @IBOutlet weak var pesoButton: UIButton!
    
    enum CurrencyType {
        case cad
        case peso
    }
    
    var currencyType: CurrencyType = .cad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cadButton.isSelected = true
    }

    @IBAction func convertButtonPressed(_ sender: Any) {
        guard let dollarsText = fromCurrencyTextField.text, let dollars = Double(dollarsText), dollars >= 0 else {
            toCurrencyTextField.text = "Please enter a valid amount"
            return
        }
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        toCurrencyTextField.text = formatter.string(for: convert(dollars: dollars, to: currencyType))
        toCurrencyTextField.backgroundColor = UIColor(red: 0.25, green: 0.9, blue: 0.35, alpha: 0.25)
    }
    
    @IBAction func cadButtonPressed(_ sender: Any) {
        guard currencyType != .cad else { return }      // if the selected currency is already CAD, we don't need to update anything
        
        currencyType = .cad
        cadButton.isSelected = true
        pesoButton.isSelected = false
        toCurrencyTextField.text = ""                    // clear out old result so it's not confusing
        toCurrencyTextField.backgroundColor = .clear
        toCurrencyLabel.text = "Currency (CAD)"
    }
    
    @IBAction func pesoButtonPressed(_ sender: Any) {
        guard currencyType != .peso else { return }      // if the selected currency is already Peso, we don't need to update anything
        
        currencyType = .peso
        cadButton.isSelected = false
        pesoButton.isSelected = true
        toCurrencyTextField.text = ""                    // clear out old result so it's not confusing
        toCurrencyTextField.backgroundColor = .clear
        toCurrencyLabel.text = "Currency (Peso)"
    }
    
    @IBAction func fromCurrencyTextFieldEdited(_ sender: Any) {
        toCurrencyTextField.backgroundColor = .clear
    }
    
    func convert(dollars: Double, to unit: CurrencyType) -> Double {
        let cadConversion = 1.31
        let pesoConversion = 19.1
        let result: Double
        
        if unit == .cad {
            result = dollars * cadConversion
        } else {
            result = dollars * pesoConversion
        }
        
        return result
    }
}

