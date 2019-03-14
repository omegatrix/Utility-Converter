//
//  WeightStruct.swift
//  Utility Converter
//
//  Created by user149138 on 3/14/19.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import Foundation

class Weight
{
    var kg: String
    var grams: String
    var ounces: String
    var pounds: String
    var stone: String
    var stonePounds: String
    
    init(kg: String, grams: String, ounces: String, pounds: String, stone: String, stonePounds: String)
    {
        self.kg = kg
        self.grams = grams
        self.ounces = ounces
        self.pounds = pounds
        self.stone = stone
        self.stonePounds = stonePounds
    }
}
