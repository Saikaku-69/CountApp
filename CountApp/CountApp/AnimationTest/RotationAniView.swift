//
//  RotationAniView.swift
//  CountApp
//
//  Created by cmStudent on 2024/07/30.
//

import SwiftUI

struct RotationAniView: View {
    @State var Size: CGFloat = 50
    @State var rotation: CGFloat = 0
    @ObservedObject var sharedata = shareData()
    
    var body: some View {
        Button(action: {
            Method()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                sharedata.isAnimating = false
            }
        }) {
            Image(systemName: "hand.thumbsup")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:Size)
                .rotationEffect(.degrees(Double(rotation)))
        }
    }
    
    private func Method() {
        let rotations: [CGFloat] = [-100,100]
        sharedata.isAnimating = true
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            withAnimation {
                if let nextrotation = rotations.randomElement() {
                    rotation = nextrotation
                }
            }
        }
    }
}

#Preview {
    RotationAniView()
}
