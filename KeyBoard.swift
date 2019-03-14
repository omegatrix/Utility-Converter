//
//  KeyBoard.swift
//  Utility Converter
//
//  Created by Emanual Mariampillai on 05/03/2019.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import UIKit

protocol KeyBoardDelegate: class
{
    func keyWasTapped(processedString: String)
    func getCurrentTxtFieldValue() -> String
}

extension UIViewController
{
    func hideKeyBoard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyBoard)
        )
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoard()
    {
        view.endEditing(true)
    }
}

class KeyBoard: UIView
{
    weak var delegate: KeyBoardDelegate?
    var negationEnabled: Bool = false
    
    @IBOutlet weak var button_negate: UIButton!
    @IBOutlet weak var button_delete: UIButton!
    @IBOutlet weak var button_decimal: UIButton!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews()
    {
        let xibFileName = "KeyBoard"
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        
        button_decimal.isUserInteractionEnabled = false
        button_delete.isUserInteractionEnabled = false
        
    }
    
    @IBAction func keyTapped(_ sender: UIButton)
    {
        let txtFieldValue: String = Helper().unwrapString(optionalString: self.delegate?.getCurrentTxtFieldValue())
        let titleLable: String = Helper().unwrapString(optionalString: sender.titleLabel?.text) //optional unwrap button label
        print("before current text field \(txtFieldValue) \n button label \(titleLable)")
        
        let processedString: String = textProcessor(stringToProcess: txtFieldValue, character: titleLable) //send the current text field value and the button label to process
        
        let changedString: String = (processedString == txtFieldValue) ? txtFieldValue : processedString //check if anything has changed with processed text field
        
        print("after processed string \(processedString)")
        
        self.delegate?.keyWasTapped(processedString: changedString) //assign the new value to the focused text field and get the latest text field value
        
        toggleButtonAvailability(txtField: changedString) //toggle "DEL" & "." accordingly

    }
    
    func toggleButtonAvailability(txtField: String)
    {
        button_delete.isUserInteractionEnabled = false
        button_decimal.isUserInteractionEnabled = false
        
        let stringHasDecimal: Bool = txtField.contains(".")
        let isStringEmpty: Bool = txtField.count == 0
        
        if(!isStringEmpty)
        {
            button_delete.isUserInteractionEnabled = true
            
            if(!stringHasDecimal)
            {
                button_decimal.isUserInteractionEnabled = true
            }
        }
    }
    
    func textProcessor(stringToProcess: String, character: String) -> String
    {
        let stringHasDecimal: Bool = stringToProcess.contains(".")
        let isStringEmpty: Bool = stringToProcess.count == 0
        let isStringHasNegation: Bool = stringToProcess.contains("-")
        let isPriorNegation: Bool = stringToProcess.last == "-"
        
        var processedString = stringToProcess
        
        if(character == "DEL")
        {
            if(!isStringEmpty)
            {
                processedString = String(stringToProcess.dropLast())
            }
        }
            
        else if(character == ".")
        {
            if(!isStringEmpty && !stringHasDecimal && !isPriorNegation)
            {
                processedString = stringToProcess + character
            }
            
        }
            
        else if(character == "+/-")
        {
            let negation: String = "-"
            processedString = isStringHasNegation ? String(stringToProcess.dropFirst()) : (negation + stringToProcess)
            
        }
            
        else
        {
            processedString = stringToProcess + character
        }
        
        return processedString
    }

}
