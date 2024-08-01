//
//  NextView.swift
//  CountApp
//
//  Created by cmStudent on 2024/07/30.
//

import SwiftUI

struct NextView: View {
    @ObservedObject var Data = data()
    var body: some View {
        Text("\(Data.number)")
    }
}

#Preview {
    NextView()
}
