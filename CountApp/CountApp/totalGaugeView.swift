//
//  totalGaugeView.swift
//  CountApp
//
//  Created by cmStudent on 2024/08/02.
//

import SwiftUI

struct totalGaugeView: View {
    @ObservedObject var sharedata = ShareData()
    
    @AppStorage("goodPoint") private var totalgood = 0.0
    @AppStorage("badPoint") private var totalbad = 0.0
    
    var body: some View {
        VStack {
            Gauge(value: sharedata.countgood) {
                //
                Text("Good:")
            }
            Gauge(value: totalbad) {
                //
                Text("Bad:")
            }
        }
    }
//    private func goodGauge() {
//        if sharedata.countgood == 1 {
//            
//        }
//    }
}

#Preview {
    totalGaugeView()
}
