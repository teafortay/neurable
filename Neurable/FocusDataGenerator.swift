//
//  FocusDataGenerator.swift
//  Neurable
//
//  Created by Taylor Shaw on 4/21/24.
// let diceRoll = Int(arc4random_uniform(6) + 1)

import Foundation

struct Sample {
var focusLevel: Float
    var dataQuality: Float
}

func generateSample() -> Sample {
    let focusLevel = Float(arc4random_uniform(100))
    let dataQuality = Float(arc4random_uniform(100))
  
    return Sample(focusLevel: focusLevel, dataQuality: dataQuality)
}

func connectionIssue() -> Bool {
    let value = Int(arc4random_uniform(100))
    return value < 10
}
