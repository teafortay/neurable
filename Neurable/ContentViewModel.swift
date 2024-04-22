//
//  ContentViewModel.swift
//  Neurable
//
//  Created by Taylor Shaw on 4/21/24.
//

import Foundation

struct DataPoint: Identifiable {
    var id = UUID()
    
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
            var sec = 0
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                let sample = generateSample()
                let dropped = connectionIssue()
                print(sample, !dropped)
                if sample.dataQuality > 30 && !dropped {
                    self.data.append(DataPoint(focusLevel: sample.focusLevel, timeInSec: sec))
                } //TODO: handle when quality is bad or dropped
                sec += 1
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
}
