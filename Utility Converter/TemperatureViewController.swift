//
//  TemperatureViewController.swift
//  Utility Converter
//
//  Created by Emanual Mariampillai on 26/02/2019.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController, UITextFieldDelegate, KeyBoardDelegate
{
    var txtField_focused = UITextField()
    var helper = Helper()

    let CELSIUS: String = "CELSIUS"
    let FAHRENHEIT: String = "FAHRENHEIT"
    let KELVIN: String = "KELVIN"
    
    
    let CELSIUS_TO_FAHRENHEIT: Double = (9/5) + 32
    let CELSIUS_TO_KELVIN: Double = 273.15
    let FAHRENHEIT_TO_CELSIUS: Double = (32) * 5/9
    let FAHRENHEIT_TO_KELVIN: Double = (32) * 5/9 + 273.15
    let KELVIN_TO_CELSIUS: Double = 273.15
    let KELVIN_TO_FAHRENHEIT: Double = (273) * 9/5 + 32

    
    @IBOutlet weak var txtField_celsius: UITextField!
    @IBOutlet weak var txtField_fahrenheit: UITextField!
    @IBOutlet weak var txtField_kelvin: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let keyboardView = KeyBoard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self
        
        txtField_celsius.delegate = self
        txtField_fahrenheit.delegate = self
        txtField_kelvin.delegate = self
        
        txtField_celsius.inputView = keyboardView
        txtField_fahrenheit.inputView = keyboardView
        txtField_kelvin.inputView = keyboardView
        
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
            let celsius: String = helper.unwrapString(optionalToUnwrap:txtField_celsius.text)
            let fahrenheit: String = helper.unwrapString(optionalToUnwrap:txtField_fahrenheit.text)
            let kelvin: String = helper.unwrapString(optionalToUnwrap:txtField_kelvin.text)
            
            let temperature: String =
                "Celsius: " + celsius +
                "\nFahrenheit: " + fahrenheit +
                "\nKelvin: " + kelvin
            
            helper.saveConversion(type: helper.TEMPERATURE, conversion: temperature)
            
            print("saving")
            print(temperature)
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
        txtField_celsius.text = ""
        txtField_fahrenheit.text = ""
        txtField_kelvin.text = ""
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
            if(!(processedString.first == "-" && processedString.count == 1))
            {
                switch txtField_focused
                {
                case txtField_celsius:
                    print("CELSIUS textfield")
                    temperatureConversion(metric: CELSIUS, value: processedString)
                    break
                    
                case txtField_fahrenheit:
                    print("FAHRENHEIT textfield")
                    temperatureConversion(metric: FAHRENHEIT, value: processedString)
                    break
                    
                case txtField_kelvin:
                    print("KELVIN textfield")
                    temperatureConversion(metric: KELVIN, value: processedString)
                    break
                    
                default:
                    print("Default textfield")
                }
            }
        }
        
        else
        {
            clearTxtFieldValue()
        }
    }
    
    func temperatureConversion(metric: String, value: String)
    {
        var string_celsius: String = "0"
        var string_fahrenheit: String = "0"
        var string_kelvin: String = "0"
        
        var double_celsius: Double = 0
        var double_fahrenheit: Double = 0
        var double_kelvin: Double = 0
        
        let workingValue: Double = Helper().unwrapDouble(optionalToUnwrap: Double(value))
        
        switch metric
        {
            case CELSIUS:
                print("CELSIUS")
                
                double_celsius = workingValue
                double_fahrenheit = (double_celsius * 9/5) + 32
                double_kelvin = double_celsius + 273.15
                
                break
            
            case FAHRENHEIT:
                print("FAHRENHEIT")
                
                double_fahrenheit = workingValue
                double_celsius = (double_fahrenheit - 32) * 5/9
                double_kelvin = (double_fahrenheit - 32) * 5/9 + 273.15
                
                break
            
            case KELVIN:
                print("KELVIN")
                
                double_kelvin = workingValue
                double_celsius = double_kelvin - 273.15
                double_fahrenheit = (double_kelvin - 273.15) * 9/5 + 32
                
                break
            
            default:
                print("default")
        }
        
        string_celsius = (metric == CELSIUS) ? value : String(format: "%.4f", double_celsius)
        string_fahrenheit = (metric == FAHRENHEIT) ? value : String(format: "%.4f", double_fahrenheit)
        string_kelvin = (metric == KELVIN) ? value : String(format: "%.4f", double_kelvin)
        
        txtField_celsius.text = string_celsius
        txtField_fahrenheit.text = string_fahrenheit
        txtField_kelvin.text = string_kelvin

    }

}

