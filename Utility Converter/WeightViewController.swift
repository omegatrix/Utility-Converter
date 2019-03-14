//
//  WeightViewController.swift
//  Utility Converter
//
//  Created by Emanual Mariampillai on 26/02/2019.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import UIKit


class WeightViewController: UIViewController, UITextFieldDelegate, KeyBoardDelegate
{
    var txtField_focused = UITextField()
    var helper = Helper()
    
    let KG: String = "KG"
    let GRAMS: String = "GRAMS"
    let OUNCES: String = "OUNCES"
    let POUNDS: String = "POUNDS"
    let STONE: String = "STONE"
    let STONE_POUND: String = "STONE_POUND"
    
    let GRAM_IN_ONE_KILOGRAM: Double = 1000
    let OUNCE_IN_ONE_KILOGRAM: Double = 35.274
    let POUND_IN_ONE_KILOGRAM: Double = 2.2046
    let STONE_IN_ONE_KILOGRAM: Double = 0.15747
    
    @IBOutlet weak var txtField_kg: UITextField!
    @IBOutlet weak var txtField_grams: UITextField!
    @IBOutlet weak var txtField_ounces: UITextField!
    @IBOutlet weak var txtField_pounds: UITextField!
    @IBOutlet weak var txtField_stone: UITextField!
    @IBOutlet weak var txtField_stonePound: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        let keyboardView = KeyBoard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self
        
        txtField_kg.delegate = self
        txtField_grams.delegate = self
        txtField_ounces.delegate = self
        txtField_pounds.delegate = self
        txtField_stone.delegate = self
        txtField_stonePound.delegate = self
        
        txtField_kg.inputView = keyboardView
        txtField_grams.inputView = keyboardView
        txtField_ounces.inputView = keyboardView
        txtField_pounds.inputView = keyboardView
        txtField_stone.inputView = keyboardView
        txtField_stonePound.inputView = keyboardView
        
        self.hideKeyBoard()
    }
    
    @IBAction func onButtonSavePressed(_ sender: UIButton)
    {
        let focusedTextFieldValue = helper.unwrapString(optionalString:txtField_focused.text)
        
        let isStringEmpty: Bool = focusedTextFieldValue.count == 0
        let endsWithDecimal: Bool = focusedTextFieldValue.last == "."
        let endsWithNegate: Bool = focusedTextFieldValue.last == "-"
        
        print("empty \(isStringEmpty) negate \(endsWithNegate) decimal \(endsWithDecimal)")
        
        if(!(isStringEmpty || endsWithNegate || endsWithDecimal))
        {
            let kg: String = helper.unwrapString(optionalString:txtField_kg.text)
            let grams: String = helper.unwrapString(optionalString:txtField_grams.text)
            let ounces: String = helper.unwrapString(optionalString:txtField_ounces.text)
            let pounds: String = helper.unwrapString(optionalString:txtField_pounds.text)
            let stone: String = helper.unwrapString(optionalString:txtField_stone.text)
            let stonePounds: String = helper.unwrapString(optionalString:txtField_stonePound.text)

            let weight: String =
                "KG: " + kg +
                "\nGrams: " + grams +
                "\nOunces: " + ounces +
                "\nPounds: " + pounds +
                "\nStone: " + stone +
                "\nStone-Pounds: " + stonePounds

            helper.saveConversion(type: helper.WEIGHT, conversion: weight)

            print("saving")
            print(weight)
        }
        
        else
        {
            let alertController = UIAlertController(title: "Alert", message: "Cannot save invalid or empty conversion!", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            {
                (action:UIAlertAction) in
                print("You've pressed ok")
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func clearTxtFieldValue()
    {
        txtField_kg.text = ""
        txtField_grams.text = ""
        txtField_ounces.text = ""
        txtField_pounds.text = ""
        txtField_stone.text = ""
        txtField_stonePound.text = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        txtField_focused = textField
        clearTxtFieldValue()
    }
    
    func getCurrentTxtFieldValue() -> String
    {
        return helper.unwrapString(optionalString: txtField_focused.text)
    }
    
    func keyWasTapped(processedString: String)
    {
        txtField_focused.text = processedString
        
        if(processedString.count > 0)
        {
            switch txtField_focused
            {
                case txtField_kg:
                    print("KG textfield")
                    weightConversion(metric: KG, value: processedString)
                    break
                
                case txtField_grams:
                    print("Grams textfield")
                    weightConversion(metric: GRAMS, value: processedString)
                    break
                
                case txtField_ounces:
                    print("Ounces textfield")
                    weightConversion(metric: OUNCES, value: processedString)
                    break
                
                case txtField_pounds:
                    print("Pounds textfield")
                    weightConversion(metric: POUNDS, value: processedString)
                    break
                
                case txtField_stone:
                    print("Stone textfield")
                    weightConversion(metric: STONE, value: processedString)
                    break
                
                case txtField_stonePound:
                    print("Stone-Pounds textfield")
                    weightConversion(metric: STONE_POUND, value: processedString)
                    break
                
                default:
                    print("Default textfield")
            }
        }
        
        else
        {
            clearTxtFieldValue()
        }
    }
    
    func weightConversion(metric: String, value: String)
    {
        var string_kg: String = "0"
        var string_grams: String = "0"
        var string_ounce: String = "0"
        var string_pound: String = "0"
        var string_stone: String = "0"
        var string_stone_pound: String = "0"
        
        var double_kg: Double = 0
        var double_grams: Double = 0
        var double_ounce: Double = 0
        var double_pound: Double = 0
        var double_stone: Double = 0
        var double_stone_pound: Double = 0
        
        let workingValue: Double = helper.unwrapDouble(optionalDouble: Double(value))
        
        switch metric
        {
            case KG:
                print("KG")
                double_kg = workingValue
                
                double_grams = double_kg * GRAM_IN_ONE_KILOGRAM
                double_ounce = double_kg * OUNCE_IN_ONE_KILOGRAM
                double_pound = double_kg * POUND_IN_ONE_KILOGRAM
                double_stone = double_kg * STONE_IN_ONE_KILOGRAM
                double_stone_pound = double_stone.truncatingRemainder(dividingBy: 1) * 14
                
                break
            
            case GRAMS:
                print("GRAMS")
                double_grams = workingValue
                
                double_kg = double_grams / GRAM_IN_ONE_KILOGRAM
                double_ounce = double_kg * OUNCE_IN_ONE_KILOGRAM
                double_pound = double_kg * POUND_IN_ONE_KILOGRAM
                double_stone = double_kg * STONE_IN_ONE_KILOGRAM
                double_stone_pound = double_stone.truncatingRemainder(dividingBy: 1) * 14
                
                break
            
            case OUNCES:
                print("OUNCES")
                double_ounce = workingValue
                
                double_kg = double_ounce / OUNCE_IN_ONE_KILOGRAM
                double_grams = double_kg * GRAM_IN_ONE_KILOGRAM
                double_pound = double_kg * POUND_IN_ONE_KILOGRAM
                double_stone = double_kg * STONE_IN_ONE_KILOGRAM
                double_stone_pound = double_stone.truncatingRemainder(dividingBy: 1) * 14
                break
            
            case POUNDS:
                print("POUNDS")
                double_pound = workingValue
                
                double_kg = double_pound / POUND_IN_ONE_KILOGRAM
                double_grams = double_kg * GRAM_IN_ONE_KILOGRAM
                double_ounce = double_kg * OUNCE_IN_ONE_KILOGRAM
                double_stone = double_kg * STONE_IN_ONE_KILOGRAM
                double_stone_pound = double_stone.truncatingRemainder(dividingBy: 1) * 14
                break
            
            case STONE:
                print("STONE")
                double_stone = workingValue
                
                double_kg = double_stone / STONE_IN_ONE_KILOGRAM
                double_grams = double_kg * GRAM_IN_ONE_KILOGRAM
                double_ounce = double_kg * OUNCE_IN_ONE_KILOGRAM
                double_pound = double_kg * POUND_IN_ONE_KILOGRAM
                double_stone_pound = double_stone.truncatingRemainder(dividingBy: 1) * 14
                
                break
            
            case STONE_POUND:
                print("STONE_POUND")
                double_stone_pound = workingValue

                double_kg = double_stone_pound / POUND_IN_ONE_KILOGRAM
                double_grams = double_kg * GRAM_IN_ONE_KILOGRAM
                double_ounce = double_kg * OUNCE_IN_ONE_KILOGRAM
                double_stone = double_kg * STONE_IN_ONE_KILOGRAM
                double_pound = double_kg * POUND_IN_ONE_KILOGRAM
                break
            
            default:
                print("default")
        }
        
        string_kg = (metric == KG) ? value : String(format: "%.4f", double_kg)
        string_grams = (metric == GRAMS) ? value : String(format: "%.4f", double_grams)
        string_ounce = (metric == OUNCES) ? value : String(format: "%.4f", double_ounce)
        string_pound = (metric == POUNDS) ? value : String(format: "%.4f", double_pound)
        string_stone = (metric == STONE) ? value : String(format: "%.4f", double_stone)
        string_stone_pound = (metric == STONE_POUND) ? value : String(format: "%.4f", double_stone_pound)
        
        txtField_kg.text = string_kg
        txtField_grams.text = string_grams
        txtField_ounces.text = string_ounce
        txtField_pounds.text = string_pound
        txtField_stone.text = string_stone
        txtField_stonePound.text = string_stone_pound
    }
}
