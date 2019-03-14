//
//  ConstantsViewController.swift
//  Utility Converter
//
//  Created by user149138 on 3/13/19.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import UIKit

class ConstantsViewController: UIViewController
{
    @IBOutlet weak var label_electronMass: UILabel!
    @IBOutlet weak var label_protonMass: UILabel!
    @IBOutlet weak var label_neutronMass: UILabel!
    @IBOutlet weak var label_electricPermittivity: UILabel!
    @IBOutlet weak var label_magneticPermeability: UILabel!
    @IBOutlet weak var label_speedOfLightMetres: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let subScriptFont = UIFont(name: "Times-Bold", size: 10.0)!
        let italicFont = UIFont(name: "Times-Italic", size: 22.0)!
        let text1 = NSMutableAttributedString()
        let text2 = NSMutableAttributedString()
        let text3 = NSMutableAttributedString()
        let text4 = NSMutableAttributedString()
        let text5 = NSMutableAttributedString()
        let text6 = NSMutableAttributedString()
        
        text1.append(NSAttributedString(string:"Electron mass  "))
        text1.append(NSAttributedString(string: "m", attributes: [NSAttributedString.Key.font: italicFont]))
        text1.append(NSAttributedString(string: "e", attributes: [NSAttributedString.Key.font: subScriptFont]))
        label_electronMass.attributedText = text1
        
        text2.append(NSAttributedString(string:"Proton mass  "))
        text2.append(NSAttributedString(string: "m", attributes: [NSAttributedString.Key.font: italicFont]))
        text2.append(NSAttributedString(string: "p", attributes: [NSAttributedString.Key.font: subScriptFont]))
        label_protonMass.attributedText = text2
        
        text3.append(NSAttributedString(string:"Neutron mass  "))
        text3.append(NSAttributedString(string: "m", attributes: [NSAttributedString.Key.font: italicFont]))
        text3.append(NSAttributedString(string: "n", attributes: [NSAttributedString.Key.font: subScriptFont]))
        label_neutronMass.attributedText = text3
        
        text4.append(NSAttributedString(string:"Electric permittivity  "))
        text4.append(NSAttributedString(string: "ε", attributes: [NSAttributedString.Key.font: italicFont]))
        text4.append(NSAttributedString(string: "0", attributes: [NSAttributedString.Key.font: subScriptFont]))
        label_electricPermittivity.attributedText = text4
        
        text5.append(NSAttributedString(string:"Magnetic permeability  "))
        text5.append(NSAttributedString(string: "μ", attributes: [NSAttributedString.Key.font: italicFont]))
        text5.append(NSAttributedString(string: "0", attributes: [NSAttributedString.Key.font: subScriptFont]))
        label_magneticPermeability.attributedText = text5
        
        text6.append(NSAttributedString(string:"Speed of light in metres  "))
        text6.append(NSAttributedString(string: "c", attributes: [NSAttributedString.Key.font: italicFont]))
        label_speedOfLightMetres.attributedText = text6
    }
    
    @IBAction func dismissView(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
}
