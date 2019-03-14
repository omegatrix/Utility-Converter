//
//  LiquidsViewController.swift
//  Utility Converter
//
//  Created by Emanual Mariampillai on 26/02/2019.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import UIKit

class LiquidsViewController: UIViewController, UITextFieldDelegate, KeyBoardDelegate
{
    var txtField_focused = UITextField()
    var helper = Helper()
    
    let GALLON: String = "GALLON"
    let LITRE: String = "LITRE"
    let UK_PINT: String = "UK_PINT"
    let FLUID_OUNCE: String = "FLUID_OUNCE"
    let MILLILITRE: String = "MILLILITRE"
    
    let LITRES_IN_ONE_GALLON: Double = 4.546
    let UK_PINTS_IN_ONE_GALLON: Double = 8
    let FLUID_OUNCE_IN_ONE_GALLON : Double = 160
    let MILLILITRE_IN_ONE_GALLON: Double = 4546.09
    
    @IBOutlet weak var txtField_gallon: UITextField!
    @IBOutlet weak var txtField_litre: UITextField!
    @IBOutlet weak var txtField_ukPint: UITextField!
    @IBOutlet weak var txtField_fluidOunce: UITextField!
    @IBOutlet weak var txtField_millilitre: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let keyboardView = KeyBoard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self
        
        txtField_gallon.delegate = self
        txtField_litre.delegate = self
        txtField_ukPint.delegate = self
        txtField_fluidOunce.delegate = self
        txtField_millilitre.delegate = self
        
        txtField_gallon.inputView = keyboardView
        txtField_litre.inputView = keyboardView
        txtField_ukPint.inputView = keyboardView
        txtField_fluidOunce.inputView = keyboardView
        txtField_millilitre.inputView = keyboardView
        
        self.hideKeyBoard()
    }
    
    @IBAction func onButtonSavePressed(_ sender: UIButton)
    {
        let focusedTextFieldValue = helper.unwrapString(optionalToUnwrap:txtField_focused.text)
        
        let isStringEmpty: Bool = focusedTextFieldValue.count == 0
        let endsWithDecimal: Bool = focusedTextFieldValue.last == "."
        let endsWithNegate: Bool = focusedTextFieldValue.last == "-"
        
        print("empty \(isStringEmpty) negate \(endsWithNegate) decimal \(endsWithDecimal)")
        
        if(!(isStringEmpty || endsWithNegate || endsWithDecimal))
        {
            let gallon: String = helper.unwrapString(optionalToUnwrap:txtField_gallon.text)
            let litre: String = helper.unwrapString(optionalToUnwrap:txtField_litre.text)
            let ukPint: String = helper.unwrapString(optionalToUnwrap:txtField_ukPint.text)
            let fluidOunce: String = helper.unwrapString(optionalToUnwrap:txtField_fluidOunce.text)
            let millilitre: String = helper.unwrapString(optionalToUnwrap:txtField_millilitre.text)
            
            let liquid: String =
                "Gallon: " + gallon +
                "\nLitre: " + litre +
                "\nUK Pint: " + ukPint +
                "\nFluid Ounce: " + fluidOunce +
                "\nMillilitre: " + millilitre
            
            helper.saveConversion(type: helper.LIQUID, conversion: liquid)
            
            print("saving")
            print(liquid)
        }
            
        else
        {
            let alertController = UIAlertController(title: "Alert", message: "Cannot save invalid or empty conversion!", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            {
                (action:UIAlertAction) in
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func clearTxtFieldValue()
    {
        txtField_gallon.text = ""
        txtField_litre.text = ""
        txtField_ukPint.text = ""
        txtField_fluidOunce.text = ""
        txtField_millilitre.text = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        txtField_focused = textField
        clearTxtFieldValue()
        print("textfield start editing \(txtField_focused.text)")
    }
    
    func getCurrentTxtFieldValue() -> String
    {
        return Helper().unwrapString(optionalToUnwrap: txtField_focused.text)
    }
    
    func keyWasTapped(processedString: String)
    {
        txtField_focused.text = processedString
        
        if(processedString.count > 0)
        {
            switch txtField_focused
            {
                case txtField_gallon:
                    print("GALLON textfield")
                    liquidConversion(metric: GALLON, value: processedString)
                    break
                
                case txtField_litre:
                    print("METRE textfield")
                    liquidConversion(metric: LITRE, value: processedString)
                    break
                
                case txtField_ukPint:
                    print("UK_PINT textfield")
                    liquidConversion(metric: UK_PINT, value: processedString)
                    break
                
                case txtField_fluidOunce:
                    print("FLUID_OUNCE textfield")
                    liquidConversion(metric: FLUID_OUNCE, value: processedString)
                    break
                
                case txtField_millilitre:
                    print("MILLILITRE textfield")
                    liquidConversion(metric: MILLILITRE, value: processedString)
                    break
                
                default:
                    print("Default textfield")
            }
        }
            
        else
        {
            clearTxtFieldValue()
        }
        
        
        
        print("inside keywastapped weight \(processedString)")
    }
    
    func liquidConversion(metric: String, value: String)
    {
        var string_gallon: String = "0"
        var string_litre: String = "0"
        var string_ukPint: String = "0"
        var string_fluidOunce: String = "0"
        var string_millilitre: String = "0"

        
        var double_gallon: Double = 0
        var double_litre: Double = 0
        var double_ukPint: Double = 0
        var double_fluidOunce: Double = 0
        var double_millilitre: Double = 0

        
        let workingValue: Double = Helper().unwrapDouble(optionalToUnwrap: Double(value))
        
        switch metric
        {
            case GALLON:
                print("GALLON")
                double_gallon = workingValue
                
                double_litre = double_gallon * LITRES_IN_ONE_GALLON
                double_ukPint = double_gallon * UK_PINTS_IN_ONE_GALLON
                double_fluidOunce = double_gallon * FLUID_OUNCE_IN_ONE_GALLON
                double_millilitre = double_gallon * MILLILITRE_IN_ONE_GALLON
                
                break
            
            case LITRE:
                print("LITRE")
                double_litre = workingValue
                
                double_gallon = double_litre / LITRES_IN_ONE_GALLON
                double_ukPint = double_gallon * UK_PINTS_IN_ONE_GALLON
                double_fluidOunce = double_gallon * FLUID_OUNCE_IN_ONE_GALLON
                double_millilitre = double_gallon * MILLILITRE_IN_ONE_GALLON
                
                break
            
            case UK_PINT:
                print("UK_PINT")
                double_ukPint = workingValue
                
                double_gallon = double_ukPint / UK_PINTS_IN_ONE_GALLON
                double_litre = double_gallon * LITRES_IN_ONE_GALLON
                double_fluidOunce = double_gallon * FLUID_OUNCE_IN_ONE_GALLON
                double_millilitre = double_gallon * MILLILITRE_IN_ONE_GALLON
                break
            
            case FLUID_OUNCE:
                print("FLUID_OUNCE")
                double_fluidOunce = workingValue
                
                double_gallon = double_fluidOunce / FLUID_OUNCE_IN_ONE_GALLON
                double_litre = double_gallon * LITRES_IN_ONE_GALLON
                double_ukPint = double_gallon * UK_PINTS_IN_ONE_GALLON
                double_millilitre = double_gallon * MILLILITRE_IN_ONE_GALLON
      
                break
            
            case MILLILITRE:
                print("MILLILITRE")
                double_millilitre = workingValue
                
                double_gallon = double_millilitre / MILLILITRE_IN_ONE_GALLON
                double_litre = double_gallon * LITRES_IN_ONE_GALLON
                double_ukPint = double_gallon * UK_PINTS_IN_ONE_GALLON
                double_fluidOunce = double_gallon * FLUID_OUNCE_IN_ONE_GALLON

                break
            
            default:
                print("default")
        }
        
        string_gallon = (metric == GALLON) ? value : String(format: "%.4f", double_gallon)
        string_litre = (metric == LITRE) ? value : String(format: "%.4f", double_litre)
        string_ukPint = (metric == UK_PINT) ? value : String(format: "%.4f", double_ukPint)
        string_fluidOunce = (metric == FLUID_OUNCE) ? value : String(format: "%.4f", double_fluidOunce)
        string_millilitre = (metric == MILLILITRE) ? value : String(format: "%.4f", double_millilitre)
        
        txtField_gallon.text = string_gallon
        txtField_litre.text = string_litre
        txtField_ukPint.text = string_ukPint
        txtField_fluidOunce.text = string_fluidOunce
        txtField_millilitre.text = string_millilitre
    }
    
}
