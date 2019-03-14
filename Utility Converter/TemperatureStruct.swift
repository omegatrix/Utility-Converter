//
//  TemperatureStruct.swift
//  Utility Converter
//
//  Created by user149138 on 3/14/19.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import Foundation

struct Temperature: Codable
{
    var celsius: String
    var fahrenheit: String
    var kelvin: String
    
    init(celsius: String, fahrenheit: String, kelvin: String)
    {
        self.celsius = celsius
        self.fahrenheit = fahrenheit
        self.kelvin = kelvin
    }
}

