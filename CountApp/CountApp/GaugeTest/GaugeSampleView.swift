//
//  GaugeSampleView.swift
//  CountApp
//
//  Created by cmStudent on 2024/08/01.
//

import SwiftUI

struct GaugeSampleView: View {
    
    @State private var progress: Double = 0.0

    var body: some View {
        VStack {
            Gauge(value: progress) {
                Text("Progress")
            }
//            .gaugeStyle(.linearCapacity)
            .tint(Gradient(colors: [.blue,.red]))

            Slider(value: $progress)
        }
        .padding()
        Button(action: {
            gaugePlus()
        }) {
            Text("プラス")
        }
        .padding()
        Button(action: {
            gaugeMinus()
        }) {
            Text("マイナス")
        }
        .padding()
    }
    
    private func gaugePlus() {
        progress += 0.1
    }
    private func gaugeMinus() {
        progress -= 0.1
    }
}

#Preview {
    GaugeSampleView()
}
