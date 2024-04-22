//
//  ContentViewModel.swift
//  Neurable
//
//  Created by Taylor Shaw on 4/21/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var isOn: Bool
    var timer: Timer?
    
    init() {
        isOn = false
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
                    print("passed")
                }
                sec += 1
                print("seconds: ", sec)
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
}
