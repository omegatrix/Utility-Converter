//
//  Helper.swift
//  Utility Converter
//
//  Created by Emanual Mariampillai on 11/03/2019.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import UIKit

struct Helper
{
    let WEIGHT: String = "WEIGHT"
    let TEMPERATURE: String = "TEMPERATURE"
    let SPEED: String = "SPEED"
    let LIQUID: String = "LIQUID"
    let LENGTH: String = "LENGTH"
    
    let WEIGHT_HISTORY: String = "WEIGHT_HISTORY"
    let TEMPERATURE_HISTORY: String = "TEMPERATURE_HISTORY"
    let SPEED_HISTORY: String = "SPEED_HISTORY"
    let LIQUID_HISTORY: String = "LIQUID_HISTORY"
    let LENGTH_HISTORY: String = "LENGTH_HISTORY"
    
    func unwrapString(optionalToUnwrap: String?) -> String
    {
        var resolvedString: String = ""
        
        if let optionalToUnwrap = optionalToUnwrap
        {
            resolvedString = optionalToUnwrap
        }
        
        return resolvedString
    }
    
    func unwrapBoolean(optionalToUnwrap: Bool?) -> Bool
    {
        var resolvedBool: Bool = false
        
        if let optionalToUnwrap = optionalToUnwrap
        {
            resolvedBool = optionalToUnwrap
        }
        
        return resolvedBool
    }
    
    func unwrapDouble(optionalToUnwrap: Double?) -> Double
    {
        var resolvedDouble: Double = 0
        
        if let optionalToUnwrap = optionalToUnwrap
        {
            resolvedDouble = optionalToUnwrap
        }
        
        return resolvedDouble
    }
    
    func saveConversion(type: String, conversion: String)
    {
        print(type)
        switch type
        {
            case WEIGHT:
                saveToUserDefaults(metricToSave: WEIGHT_HISTORY, conversionToSave: conversion)
            break

            case TEMPERATURE:
                saveToUserDefaults(metricToSave: TEMPERATURE_HISTORY, conversionToSave: conversion)
            break

            case SPEED:
                saveToUserDefaults(metricToSave: SPEED_HISTORY, conversionToSave: conversion)
            break

            case LIQUID:
                saveToUserDefaults(metricToSave: LIQUID_HISTORY, conversionToSave: conversion)
            break

            case LENGTH:
                saveToUserDefaults(metricToSave: LENGTH_HISTORY, conversionToSave: conversion)
            break

            default:
                return
        }
    }
    
    func getHistory(type: String) -> [String]
    {
    
        let dataArray =  UserDefaults.standard.object(forKey: type) as? [String] ?? [String]()
        
        return dataArray
    }
    
    func saveToUserDefaults(metricToSave: String, conversionToSave: String)
    {
        if (UserDefaults.standard.object(forKey: metricToSave) != nil)
        {
            print("print inside if")
            var dataArray = UserDefaults.standard.object(forKey: metricToSave) as? [String] ?? [String]()
            
            let arrSize = dataArray.count
            
            if(arrSize == 5)
            {
                let modifiedArray = dataArray.dropFirst()
                dataArray = Array(modifiedArray)
                dataArray.append(conversionToSave)
                
                UserDefaults.standard.set(dataArray, forKey: metricToSave)
            }
                
            else
            {
                dataArray.append(conversionToSave)
                UserDefaults.standard.set(dataArray, forKey: metricToSave)
            }
        }
            
        else
        {
            print("inside else")
            let newHistoryArray = [conversionToSave]
            UserDefaults.standard.set(newHistoryArray, forKey: metricToSave)
        }
    }
    
}

