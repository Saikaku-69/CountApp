//
//  graphView.swift
//  CountApp
//
//  Created by cmStudent on 2024/08/06.
//

import SwiftUI

struct graphView: View {
    var sharedata : ShareData
    
    @Environment(\.dismiss) var dm
    @State private var graph1: Double = 0.0
    @State private var graph2: Double = 0.0
    
    var body: some View {
        VStack(alignment: .trailing) {
            Button(action: {
                dm()
            }) {
                Text("戻る")
            }
            
            Spacer()
            
            Gauge(value: sharedata.countgood * 0.1) {
                Text("良いと思う人")
                    .background(.yellow)
            }
            .tint(.green)
            .padding(.bottom, 20)
            Gauge(value: sharedata.countbad * 0.1) {
                Text("悪いと思う人")
                    .background(.red)
            }
            .tint(.red)
        }
        .frame(width:UIScreen.main.bounds.width-50,height: 250)
    }
}

#Preview {
    graphView(sharedata: ShareData())
}
