/*
 This struct is being used by ViewControllers and provides
 commom functionality such as optional unwrapping, Userdefault save and retrieve
 */

import UIKit

struct Helper
{
    /* Metrics */
    let WEIGHT: String = "WEIGHT"
    let TEMPERATURE: String = "TEMPERATURE"
    let SPEED: String = "SPEED"
    let LIQUID: String = "LIQUID"
    let LENGTH: String = "LENGTH"
    
    /* Metric history identifiers */
    let WEIGHT_HISTORY: String = "WEIGHT_HISTORY"
    let TEMPERATURE_HISTORY: String = "TEMPERATURE_HISTORY"
    let SPEED_HISTORY: String = "SPEED_HISTORY"
    let LIQUID_HISTORY: String = "LIQUID_HISTORY"
    let LENGTH_HISTORY: String = "LENGTH_HISTORY"
    
    /* Optional unwrap -> String */
    func unwrapString(optionalString: String?) -> String
    {
        var unWrappedString: String = "" //default value to return
        
        if let optionalString = optionalString
        {
            unWrappedString = optionalString
        }
        
        print("Optional String unwraped -> \(unWrappedString)")
        return unWrappedString
    }
    
    /* Optional unwrap -> Bool */
    func unwrapBoolean(optionalBool: Bool?) -> Bool
    {
        var unWrappedBool: Bool = false //default value to return
        
        if let optionalBool = optionalBool
        {
            unWrappedBool = optionalBool
        }
        
        print("Optional Bool unwraped -> \(unWrappedBool)")
        return unWrappedBool
    }
    
    /* Optional unwrap -> Double */
    func unwrapDouble(optionalDouble: Double?) -> Double
    {
        var unWrappedDouble: Double = 0.0 //default value to return
        
        if let optionalDouble = optionalDouble
        {
            unWrappedDouble = optionalDouble
        }
        
        print("Optional Bool unwraped -> \(unWrappedDouble)")
        return unWrappedDouble
    }
    
    /* Prepares the saving data to User defaults by passing
       the Metric History identifier along with the conversion to save */
    func saveConversion(type: String, conversion: String)
    {
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
    
    /*
         Saves data to User Defaults by satisfying one of the following conditions.
     
         (1) if User Default holds a key for the parameter 'metricToSave'
             then :
                -> if the length of the retrived metric data array is 5
                    then remove the element at index 0 and append the new conversion to save.
     
                -> else append the new conversion to save to the retrieved metric data array
     
     (2) else User Defaults does not hold a key for the parameter 'metricToSave' then :
            create a new key value to hold the metric history
    */
    func saveToUserDefaults(metricToSave: String, conversionToSave: String)
    {
        if (UserDefaults.standard.object(forKey: metricToSave) != nil)
        {
            var dataArray = UserDefaults.standard.object(forKey: metricToSave) as? [String] ?? [String]()
            let arrSize = dataArray.count
            
            if(arrSize == 5)
            {
                let modifiedArray = dataArray.dropFirst() //removes the element at [0]
                dataArray = Array(modifiedArray) //[String] -> <String>
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
            let newHistoryArray = [conversionToSave]
            UserDefaults.standard.set(newHistoryArray, forKey: metricToSave)
        }
    }
    
    /* retrives the data array of the given metric history identifier */
    func getHistory(type: String) -> [String]
    {
        let dataArray =  UserDefaults.standard.object(forKey: type) as? [String] ?? [String]()
        
        return dataArray
    }
}

