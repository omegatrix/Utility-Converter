//
//  HistoryViewController.swift
//  Utility Converter
//
//  Created by user149138 on 3/13/19.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController
{
    let helper = Helper() // helper struct
    var selectedMetric: String = ""
    
    var weightArray = [String]()
    var temperatureArray = [String]()
    var liquidArray = [String]()
    var speedArray = [String]()
    var lengthArray = [String]()
    var labelArray = [UILabel]()
    
    @IBOutlet weak var button_weightHistory: UIButton!
    @IBOutlet weak var button_temperatureHistory: UIButton!
    @IBOutlet weak var button_liquidHistory: UIButton!
    @IBOutlet weak var button_speedHistory: UIButton!
    @IBOutlet weak var button_lengthHistory: UIButton!
    
    @IBOutlet weak var label_0: UILabel!
    @IBOutlet weak var label_1: UILabel!
    @IBOutlet weak var label_2: UILabel!
    @IBOutlet weak var label_3: UILabel!
    @IBOutlet weak var label_4: UILabel!
  
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        weightArray =  helper.getHistory(type: helper.WEIGHT_HISTORY)
        temperatureArray = helper.getHistory(type: helper.TEMPERATURE_HISTORY)
        liquidArray =  helper.getHistory(type: helper.LIQUID_HISTORY)
        speedArray = helper.getHistory(type: helper.SPEED_HISTORY)
        lengthArray = helper.getHistory(type: helper.LENGTH_HISTORY)
        
        selectedMetric = helper.WEIGHT_HISTORY
        
        labelArray = [label_0, label_1, label_2, label_3, label_4]
        
        populateLabels()
    }
    
    @IBAction func dismissView(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onMetricButtonPressed(_ sender: UIButton)
    {
        clearLabelContent()
        
        switch sender
        {
            case button_weightHistory:
                selectedMetric = helper.WEIGHT_HISTORY
            break

            case button_temperatureHistory:
                selectedMetric = helper.TEMPERATURE_HISTORY
            break

            case button_liquidHistory:
                selectedMetric = helper.LIQUID_HISTORY
            break

            case button_speedHistory:
                selectedMetric = helper.SPEED_HISTORY
            break

            case button_lengthHistory:
                selectedMetric = helper.LENGTH_HISTORY
            break

            default:
                return
        }
        
        populateLabels()
    }
    
    func populateLabels()
    {
        switch selectedMetric
        {
            case helper.WEIGHT_HISTORY:
                changeLabelContent(workinngArray: weightArray)
            break
            
            case helper.TEMPERATURE_HISTORY:
                changeLabelContent(workinngArray: temperatureArray)
            break
            
            case helper.SPEED_HISTORY:
                changeLabelContent(workinngArray: speedArray)
            break
            
            case helper.LIQUID_HISTORY:
                changeLabelContent(workinngArray: liquidArray)
            break
            
            case helper.LENGTH_HISTORY:
                changeLabelContent(workinngArray: lengthArray)
            break

            default:
                return
        }
    }
    
    func clearLabelContent()
    {
        let maxIndex = (labelArray.count - 1)
        
        for index in 0...maxIndex
        {
            labelArray[index].text = ""
        }
    }
    
    func changeLabelContent(workinngArray: [String])
    {
        if(workinngArray.count > 0)
        {
            let maxIndex = (workinngArray.count - 1)
            
            for index in 0...maxIndex
            {
                labelArray[index].text = workinngArray[index]
            }
        }
            
        else
        {
            label_0.text = "No saved data available!"
        }
    }
    
}
