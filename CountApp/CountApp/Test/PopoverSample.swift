//
//  PopoverSample.swift
//  CountApp
//
//  Created by cmStudent on 2024/08/25.
//

import SwiftUI

struct PopoverSample: View {
    
    @State private var isPopoverPresented = false

    var body: some View {
        VStack {
            Button("Show Popover") {
                isPopoverPresented = true
            }
            .popover(isPresented: $isPopoverPresented) {
                VStack {
                    Text("这是一个 Popover")
                    Button("关闭") {
                        isPopoverPresented = false
                    }
                }
                .frame(width: 300, height: 200)
                .presentationDetents([.medium, .fraction(0.3)])
            }
        }
    }
}

#Preview {
    PopoverSample()
}
