//
//  ContentViewModel.swift
//  Neurable
//
//  Created by Taylor Shaw on 4/21/24.
//

import Foundation

struct DataPoint: Identifiable {
    let id = UUID()
    var series: Int
    var focusLevel: Float
    var timeInSec: Int
}

class ContentViewModel: ObservableObject {
    @Published var isOn: Bool
    @Published var data: [DataPoint]
    var timer: Timer?
    var seriesNum: Int
    
    init() {
        isOn = false
        data = []
        seriesNum = 0
    }
    
    func toggleButton() {
        isOn.toggle()
        if isOn {
            // start new line
            seriesNum += 1
            var offSec = 0
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                let sample = generateSample()
                let dropped = connectionIssue()
                print(sample, !dropped)
                if sample.dataQuality > 30 && !dropped {
                    self.data.append(DataPoint(series: self.seriesNum, focusLevel: sample.focusLevel, timeInSec: offSec))
                } else {
                    // when quality is bad or dropped
                    self.seriesNum += 1
                    
                }
                offSec += 1
            }
        } else {
            // TODO: create session data and validate, handle so don't resetsecs to 0
            timer?.invalidate()
            timer = nil
        }
    }
}
