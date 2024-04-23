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
    
    init() {
        isOn = false
        data = []
    }
    
    func toggleButton() {
        isOn.toggle()
        if isOn {
            var sesh = FocusData_Session()
            var seriesNum = 0
            var offSec = 0
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                let sample = generateSample()
                let dropped = connectionIssue()
                print(sample, !dropped, seriesNum)
                if sample.dataQuality > 30 && !dropped {
                    self.data.append(DataPoint(series: seriesNum, focusLevel: sample.focusLevel, timeInSec: offSec))
                } else {
                    // when quality is bad or dropped
                    seriesNum += 1
                }
                var dataSample = FocusData_Session.DataSample()
                dataSample.offsetSeconds = Int32(offSec)
                dataSample.dataQuality = sample.dataQuality
                dataSample.focusLevel = sample.focusLevel
                sesh.data.append(dataSample)
                offSec += 1
            }
        } else {
            // TODO: create session data and validate, handle so don't resetsecs to 0
            self.data = []
            timer?.invalidate()
            timer = nil
        }
    }
}
