//
//  ContentView.swift
//  Neurable
//
//  Created by Taylor Shaw on 4/19/24.
//

import SwiftUI
import Charts

struct DataPoint: Identifiable {
    var id = UUID()
    
    var focusLevel: Float
    var timeInSec: Int
}

var data: [DataPoint] = [
    DataPoint(focusLevel: 60.0, timeInSec: 1),
    DataPoint(focusLevel: 46.5, timeInSec: 2),
    DataPoint(focusLevel: 78.4, timeInSec: 3),
    DataPoint(focusLevel: 31.2, timeInSec: 4),
    DataPoint(focusLevel: 98.1, timeInSec: 5)
]

struct ContentView: View {
    @ObservedObject var viewmodel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Neurable Demo")
            Chart(data) {
                    LineMark(
                        x: .value("", $0.timeInSec),
                        y: .value("", $0.focusLevel)
                    )
                    .foregroundStyle(.bar)
                    .lineStyle(StrokeStyle(lineWidth: 10, lineJoin: .round))
                }
            
            Spacer()
            HStack {
                Spacer()
            Button(action: {
                viewmodel.toggleButton()
            }, label: {
                viewmodel.isOn ? Image(systemName: "stop") : Image(systemName: "play")
            })
            Spacer()
        }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
