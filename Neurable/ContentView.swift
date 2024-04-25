//
//  ContentView.swift
//  Neurable
//
//  Created by Taylor Shaw on 4/19/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    @ObservedObject private var viewmodel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("Neurable Demo")
            Chart(viewmodel.data) {
                LineMark(
                    x: .value("", $0.timeInSec),
                    y: .value("", $0.focusLevel)
                )
                .foregroundStyle(.bar)
                .foregroundStyle(by: .value("", $0.series))
                .lineStyle(StrokeStyle(lineWidth: 6, lineJoin: .round))
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
