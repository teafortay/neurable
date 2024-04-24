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
    var sesh: FocusData_Session?
    
    init() {
        isOn = false
        data = []
    }
    
    func toggleButton() {
        isOn.toggle()
        if isOn {
            self.data = []
            self.sesh = FocusData_Session()
            var seriesNum = 0
            var offSec = 0
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                let sample = generateSample()
                let dropped = connectionIssue()
                
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
                self.sesh?.data.append(dataSample)
                
                offSec += 1
            }
        } else {
            // pressed stop button
            do {
                let res = try ProtobufValidator().validate(data: sesh?.serializedData() ?? Data())
                switch res {
                case .success():
                    // I would access my networking layer here to upload the data
                    return
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            timer?.invalidate()
            timer = nil
            sesh = nil
        }
    }
}
