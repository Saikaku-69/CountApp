//
//  BindingView.swift
//  CountApp
//
//  Created by cmStudent on 2024/07/30.
//

import SwiftUI

struct BindingView: View {
    
    @ObservedObject var Data = data()
    
    var body: some View {
        Text("\(Data.number)")
        Button(action: {
            test()
        }) {
            Text("test")
        }
    }
    private func test() {
        Data.number += 1
    }
}

#Preview {
    BindingView()
}
