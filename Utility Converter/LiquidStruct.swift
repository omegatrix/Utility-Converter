//
//  LiquidStruct.swift
//  Utility Converter
//
//  Created by user149138 on 3/14/19.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import Foundation

struct Liquid: Codable
{
    var gallon: String
    var litre: String
    var ukPint: String
    var fluidOunce: String
    var millilitre: String
    
    init(gallon: String, litre: String, ukPint: String, fluidOunce: String, millilitre: String)
    {
        self.gallon = gallon
        self.litre = litre
        self.ukPint = ukPint
        self.fluidOunce = fluidOunce
        self.millilitre = millilitre
    }
}
