//
//  LengthStruct.swift
//  Utility Converter
//
//  Created by user149138 on 3/14/19.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import Foundation

struct Length: Codable
{
    var metre: String
    var mile: String
    var cm: String
    var mm: String
    var yard: String
    var inch: String
    
    init(metre: String, mile: String, cm: String, mm: String, yard: String, inch: String)
    {
        self.metre = metre
        self.mile = mile
        self.cm = cm
        self.mm = mm
        self.yard = yard
        self.inch = inch
    }
}
