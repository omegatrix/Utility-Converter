//
//  SpeedViewController.swift
//  Utility Converter
//
//  Created by Emanual Mariampillai on 26/02/2019.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import UIKit

class SpeedViewController: UIViewController, UITextFieldDelegate, KeyBoardDelegate
{
    var txtField_focused = UITextField()
    var helper = Helper()
    
    let METRE_PER_SECOND: String = "METRE_PER_SECOND"
    let KILOMETRE_PER_HOUR: String = "KILOMETRE_PER_HOUR"
    let MILES_PER_HOUR: String = "MILES_PER_HOUR"
    let NAUTICAL_MILES_PER_HOUR: String = "NAUTICAL_MILES_PER_HOUR"
    
    let METRE_PER_SECOND_TO_KILOMETRE_PER_HOUR: Double = 3.6
    let MILES_PER_HOUR_TO_KILOMETRE_PER_HOUR: Double = 1.609
    let NAUTICAL_MILES_PER_HOUR_TO_KILOMETRE_PER_HOUR: Double = 1.852
    
    @IBOutlet weak var txtField_metresPerSecond: UITextField!
    @IBOutlet weak var txtField_kmPerHour: UITextField!
    @IBOutlet weak var txtField_milesPerHour: UITextField!
    @IBOutlet weak var txtField_nauticalMilesPerHour: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let keyboardView = KeyBoard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        keyboardView.delegate = self
        
        txtField_metresPerSecond.delegate = self
        txtField_kmPerHour.delegate = self
        txtField_milesPerHour.delegate = self
        txtField_nauticalMilesPerHour.delegate = self
        
        txtField_metresPerSecond.inputView = keyboardView
        txtField_kmPerHour.inputView = keyboardView
        txtField_milesPerHour.inputView = keyboardView
        txtField_nauticalMilesPerHour.inputView = keyboardView
        
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
            let metresPerSecond: String = helper.unwrapString(optionalString:txtField_metresPerSecond.text)
            let kmPerHour: String = helper.unwrapString(optionalString:txtField_kmPerHour.text)
            let milesPerHour: String = helper.unwrapString(optionalString:txtField_milesPerHour.text)
            let nauticalMilesPerHour: String = helper.unwrapString(optionalString:txtField_nauticalMilesPerHour.text)
            
            let speed: String =
                "Metres per second: " + metresPerSecond +
                "\nKM per hour: " + kmPerHour +
                "\nMiles per hour: " + milesPerHour +
                "\nNautical miles per hour: " + nauticalMilesPerHour
            
            helper.saveConversion(type: helper.SPEED, conversion: speed)
            
            print("saving")
            print(speed)
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
        txtField_metresPerSecond.text = ""
        txtField_kmPerHour.text = ""
        txtField_milesPerHour.text = ""
        txtField_nauticalMilesPerHour.text = ""
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
            case txtField_metresPerSecond:
                print("METRE_PER_SECOND")
                speedConversion(metric: METRE_PER_SECOND, value: processedString)
                break
                
            case txtField_kmPerHour:
                print("KILOMETRE_PER_HOUR")
                speedConversion(metric: KILOMETRE_PER_HOUR, value: processedString)
                break
                
            case txtField_milesPerHour:
                print("MILES_PER_HOUR")
                speedConversion(metric: MILES_PER_HOUR, value: processedString)
                break
                
            case txtField_nauticalMilesPerHour:
                print("NAUTICAL_MILES_PER_HOUR")
                speedConversion(metric: NAUTICAL_MILES_PER_HOUR, value: processedString)
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
    
    func speedConversion(metric: String, value: String)
    {
        var string_metresPerSecond: String = "0"
        var string_kmPerHour: String = "0"
        var string_milesPerHour: String = "0"
        var string_nauticalMilesPerHour: String = "0"
        
        var double_metresPerSecond: Double = 0
        var double_kmPerHour: Double = 0
        var double_milesPerHour: Double = 0
        var double_nauticalMilesPerHour: Double = 0
        
        let workingValue: Double = Helper().unwrapDouble(optionalDouble: Double(value))
        
        switch metric
        {
            case METRE_PER_SECOND:
                print("METRE_PER_SECOND")
                double_metresPerSecond = workingValue
                
                double_kmPerHour = double_metresPerSecond * METRE_PER_SECOND_TO_KILOMETRE_PER_HOUR
                double_milesPerHour = double_kmPerHour / MILES_PER_HOUR_TO_KILOMETRE_PER_HOUR
                double_nauticalMilesPerHour = double_kmPerHour / NAUTICAL_MILES_PER_HOUR_TO_KILOMETRE_PER_HOUR
                break
            
            case KILOMETRE_PER_HOUR:
                print("KILOMETRE_PER_HOUR")
                double_kmPerHour = workingValue
                
                double_metresPerSecond = double_kmPerHour / METRE_PER_SECOND_TO_KILOMETRE_PER_HOUR
                double_milesPerHour = double_kmPerHour / MILES_PER_HOUR_TO_KILOMETRE_PER_HOUR
                double_nauticalMilesPerHour = double_kmPerHour / NAUTICAL_MILES_PER_HOUR_TO_KILOMETRE_PER_HOUR
                
                break
            
            case MILES_PER_HOUR:
                print("MILES_PER_HOUR")
                double_milesPerHour = workingValue
                
                double_kmPerHour = double_milesPerHour * MILES_PER_HOUR_TO_KILOMETRE_PER_HOUR
                double_metresPerSecond = double_kmPerHour / METRE_PER_SECOND_TO_KILOMETRE_PER_HOUR
                double_nauticalMilesPerHour = double_kmPerHour / NAUTICAL_MILES_PER_HOUR_TO_KILOMETRE_PER_HOUR
                
                break
            
            case NAUTICAL_MILES_PER_HOUR:
                print("NAUTICAL_MILES_PER_HOUR")
                double_nauticalMilesPerHour = workingValue
                
                double_kmPerHour = double_nauticalMilesPerHour * NAUTICAL_MILES_PER_HOUR_TO_KILOMETRE_PER_HOUR
                double_metresPerSecond = double_kmPerHour / METRE_PER_SECOND_TO_KILOMETRE_PER_HOUR
                double_milesPerHour = double_kmPerHour / MILES_PER_HOUR_TO_KILOMETRE_PER_HOUR
                
                break
            
            default:
                print("Default textfield")
        }
        
        
        string_metresPerSecond = (metric == METRE_PER_SECOND) ? value : String(format: "%.4f", double_metresPerSecond)
        string_kmPerHour = (metric == KILOMETRE_PER_HOUR) ? value : String(format: "%.4f", double_kmPerHour)
        string_milesPerHour = (metric == MILES_PER_HOUR) ? value : String(format: "%.4f", double_milesPerHour)
        string_nauticalMilesPerHour = (metric == NAUTICAL_MILES_PER_HOUR) ? value : String(format: "%.4f", double_nauticalMilesPerHour)
        
        txtField_metresPerSecond.text = string_metresPerSecond
        txtField_kmPerHour.text = string_kmPerHour
        txtField_milesPerHour.text = string_milesPerHour
        txtField_nauticalMilesPerHour.text = string_nauticalMilesPerHour
        
    }
    

}
