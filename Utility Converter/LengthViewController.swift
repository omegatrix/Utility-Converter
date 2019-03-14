//
//  LengthViewController.swift
//  Utility Converter
//
//  Created by Emanual Mariampillai on 05/03/2019.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import UIKit

class LengthViewController: UIViewController, UITextFieldDelegate, KeyBoardDelegate
{
    var txtField_focused = UITextField()
    var helper = Helper()
    
    let METRE: String = "METRE"
    let MILE: String = "MILE"
    let CM: String = "CM"
    let MM: String = "MM"
    let YARD: String = "YARD"
    let INCH: String = "INCH"
    
    let METRES_IN_ONE_MILE: Double = 1609.344
    let CM_IN_ONE_MILE: Double = 160934.4
    let MM_IN_ONE_MILE : Double = 1609344
    let YARD_IN_ONE_MILE: Double = 1760
    let INCH_IN_ONE_MILE: Double = 63360
    
    @IBOutlet weak var txtField_metre: UITextField!
    @IBOutlet weak var txtField_mile: UITextField!
    @IBOutlet weak var txtField_cm: UITextField!
    @IBOutlet weak var txtField_mm: UITextField!
    @IBOutlet weak var txtField_yard: UITextField!
    @IBOutlet weak var txtField_inch: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let keyboardView = KeyBoard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self
        
        txtField_metre.delegate = self
        txtField_mile.delegate = self
        txtField_cm.delegate = self
        txtField_mm.delegate = self
        txtField_yard.delegate = self
        txtField_inch.delegate = self
        
        txtField_metre.inputView = keyboardView
        txtField_mile.inputView = keyboardView
        txtField_cm.inputView = keyboardView
        txtField_mm.inputView = keyboardView
        txtField_yard.inputView = keyboardView
        txtField_inch.inputView = keyboardView
        
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
            let metre: String = helper.unwrapString(optionalString:txtField_metre.text)
            let mile: String = helper.unwrapString(optionalString:txtField_mile.text)
            let cm: String = helper.unwrapString(optionalString:txtField_cm.text)
            let mm: String = helper.unwrapString(optionalString:txtField_mm.text)
            let yard: String = helper.unwrapString(optionalString:txtField_yard.text)
            let inch: String = helper.unwrapString(optionalString:txtField_inch.text)
            
            let length: String = "Metre: \(metre) \nMile: \(mile) \nCM: \(cm) \nMM: \(mm) \nYard: \(yard) \nInch: \(inch)"
            
            helper.saveConversion(type: helper.LENGTH, conversion: length)
            
            print("saving")
            print(length)
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
        txtField_metre.text = ""
        txtField_mile.text = ""
        txtField_cm.text = ""
        txtField_mm.text = ""
        txtField_yard.text = ""
        txtField_inch.text = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        txtField_focused = textField
        clearTxtFieldValue()
        print("textfield start editing \(txtField_focused.text)")
    }
    
    func getCurrentTxtFieldValue() -> String
    {
        return Helper().unwrapString(optionalString: txtField_focused.text)
    }
    
    func keyWasTapped(processedString: String)
    {
        txtField_focused.text = processedString
        
        if(processedString.count > 0)
        {
            switch txtField_focused
            {
            case txtField_metre:
                print("METRE textfield")
                lengthConversion(metric: METRE, value: processedString)
                break
                
            case txtField_mile:
                print("METRE textfield")
                lengthConversion(metric: MILE, value: processedString)
                break
                
            case txtField_cm:
                print("CM textfield")
                lengthConversion(metric: CM, value: processedString)
                break
                
            case txtField_mm:
                print("MM textfield")
                lengthConversion(metric: MM, value: processedString)
                break
                
            case txtField_yard:
                print("YARD textfield")
                lengthConversion(metric: YARD, value: processedString)
                break
                
            case txtField_inch:
                print("INCH textfield")
                lengthConversion(metric: INCH, value: processedString)
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
    
    func lengthConversion(metric: String, value: String)
    {
        var string_metre: String = "0"
        var string_mile: String = "0"
        var string_cm: String = "0"
        var string_mm: String = "0"
        var string_yard: String = "0"
        var string_inch: String = "0"
        
        var double_metre: Double = 0
        var double_mile: Double = 0
        var double_cm: Double = 0
        var double_mm: Double = 0
        var double_yard: Double = 0
        var double_inch: Double = 0
        
        let workingValue: Double = Helper().unwrapDouble(optionalDouble: Double(value))
        
        switch metric
        {
            case METRE:
                print("METRE")
                double_metre = workingValue
                
                double_mile = double_metre / METRES_IN_ONE_MILE
                double_cm = double_mile * CM_IN_ONE_MILE
                double_mm = double_mile * MM_IN_ONE_MILE
                double_yard = double_mile * YARD_IN_ONE_MILE
                double_inch = double_mile * INCH_IN_ONE_MILE
                
                break
            
            case MILE:
                print("MILE")
                double_mile = workingValue
                
                double_metre = double_mile * METRES_IN_ONE_MILE
                double_cm = double_mile * CM_IN_ONE_MILE
                double_mm = double_mile * MM_IN_ONE_MILE
                double_yard = double_mile * YARD_IN_ONE_MILE
                double_inch = double_mile * INCH_IN_ONE_MILE
                
                break
            
            case CM:
                print("CM")
                double_cm = workingValue
                
                double_mile = double_cm / CM_IN_ONE_MILE
                double_metre = double_mile * METRES_IN_ONE_MILE
                double_mm = double_mile * MM_IN_ONE_MILE
                double_yard = double_mile * YARD_IN_ONE_MILE
                double_inch = double_mile * INCH_IN_ONE_MILE
                break
            
            case MM:
                print("MM")
                double_mm = workingValue
                
                double_mile = double_mm / MM_IN_ONE_MILE
                double_metre = double_mile * METRES_IN_ONE_MILE
                double_cm = double_mile * CM_IN_ONE_MILE
                double_yard = double_mile * YARD_IN_ONE_MILE
                double_inch = double_mile * INCH_IN_ONE_MILE
                break
            
            case YARD:
                print("YARD")
                double_yard = workingValue
                
                double_mile = double_yard / YARD_IN_ONE_MILE
                double_metre = double_mile * METRES_IN_ONE_MILE
                double_cm = double_mile * CM_IN_ONE_MILE
                double_mm = double_mile * MM_IN_ONE_MILE
                double_inch = double_mile * INCH_IN_ONE_MILE
                break
            
            case INCH:
                print("INCH")
                double_inch = workingValue
                
                double_mile = double_inch / INCH_IN_ONE_MILE
                double_metre = double_mile * METRES_IN_ONE_MILE
                double_cm = double_mile * CM_IN_ONE_MILE
                double_mm = double_mile * MM_IN_ONE_MILE
                double_yard = double_mile * YARD_IN_ONE_MILE
                break
            
            default:
                print("default")
        }
        
        string_metre = (metric == METRE) ? value : String(format: "%.4f", double_metre)
        string_mile = (metric == MILE) ? value : String(format: "%.4f", double_mile)
        string_cm = (metric == CM) ? value : String(format: "%.4f", double_cm)
        string_mm = (metric == MM) ? value : String(format: "%.4f", double_mm)
        string_yard = (metric == YARD) ? value : String(format: "%.4f", double_yard)
        string_inch = (metric == INCH) ? value : String(format: "%.4f", double_inch)
        
        txtField_metre.text = string_metre
        txtField_mile.text = string_mile
        txtField_cm.text = string_cm
        txtField_mm.text = string_mm
        txtField_yard.text = string_yard
        txtField_inch.text = string_inch
    }

}
