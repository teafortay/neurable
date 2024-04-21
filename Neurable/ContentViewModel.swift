//
//  ContentViewModel.swift
//  Neurable
//
//  Created by Taylor Shaw on 4/21/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var isOn: Bool
    
    init() {
        isOn = false
    }
    
    func toggleButton() {
        isOn.toggle()
    }
}
