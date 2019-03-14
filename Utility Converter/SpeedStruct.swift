//
//  SpeedStruct.swift
//  Utility Converter
//
//  Created by user149138 on 3/14/19.
//  Copyright © 2019 Arnold Anthonypillai. All rights reserved.
//

import Foundation

struct Speed: Codable
{
    var metresPerSec: String
    var kmPerHour: String
    var milesPerHour: String
    var knots: String
    
    init(metresPerSec: String, kmPerHour: String, milesPerHour: String, knots: String)
    {
        self.metresPerSec = metresPerSec
        self.kmPerHour = kmPerHour
        self.milesPerHour = milesPerHour
        self.knots = knots
    }
}
