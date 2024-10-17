//
//  GradientExView.swift
//  CountApp
//
//  Created by cmStudent on 2024/08/07.
//

import SwiftUI

struct GradientExView: View {
    @State var isOn:Bool = false
    var body: some View {
        Rectangle()
            .fill (
                LinearGradient(gradient: Gradient(colors: [.red,.blue,.yellow,.green,.brown]), startPoint: .leading, endPoint: .trailing)
            )
            .frame(width:200, height: 50)
            .padding(.bottom)
        
        Rectangle()
            .fill (
                LinearGradient(gradient:Gradient(colors:[.red,.blue,.yellow,.green,.brown]),
                               startPoint: .top, endPoint: .bottom)
            )
            .frame(width:200, height: 50)
        
        Circle()
            .fill(
                AngularGradient(gradient: Gradient(colors:[.red,.blue,.orange,.green,.yellow]),
                                center: .center
            ))
            .frame(width: 100)
        HStack {
            Button(action: {
                isOn = true
            }) {
                Circle()
                    .fill(
                        AngularGradient(gradient: Gradient(colors:[.red,.blue,.orange,.green,.yellow]),
                                        center: .top
                                       ))
                    .frame(width: 100)
            }
        }.sheet(isPresented: $isOn) {
            GaugeSampleView()
                .presentationDetents([.medium])
//                .presentationDragIndicator(.visible)
        }
        
            
        
        Circle()
            .fill(
                RadialGradient(gradient: Gradient(colors:[.red,.blue,.orange,.green,.yellow]),
                                center: .center,
                               startRadius: 0,
                               endRadius: 100
            ))
            .frame(width: 100)
    }
}

#Preview {
    GradientExView()
}
