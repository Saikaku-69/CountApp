//
//  StartView.swift
//  CountApp
//
//  Created by cmStudent on 2024/08/01.
//

import SwiftUI

struct StartView: View {
    @ObservedObject var sharedata = ShareData()
    @State var leftBoxSize: CGFloat = 400
    @State var topBoxSize: CGFloat = 600
    @State var buttonSize: CGFloat = 0
    
    var body: some View {
        ZStack {
            
            //縦ボード
            VStack {
                HStack(alignment:.top,spacing: 30) {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 30,height:topBoxSize - 300)
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(width: 30,height:topBoxSize - 150)
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 30,height:topBoxSize)
                }
                Spacer()
            }
            .padding(.leading,120)
            
            //横ボード
            HStack {
                VStack(alignment:.leading,spacing: 30) {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: leftBoxSize - 200,height:30)
                    Rectangle()
                        .fill(Color.orange)
                        .frame(width: leftBoxSize - 100,height:30)
                    Rectangle()
                        .fill(Color.purple)
                        .frame(width: leftBoxSize,height:30)
                }
                Spacer()
            }
            //開始ボタン
            Button(action: {
                moveBord()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    buttonColor()
                }
            }) {
                ZStack {
                    Circle().stroke(.gray)
                        .frame(width: 80)
                    Circle()
                        .fill(.green)
                        .frame(width: buttonSize)
                    Image(systemName: "figure.2")
                        .font(.system(size:40))
                        .foregroundColor(.black)
                }
            }
            Text("loading...")
                .background(.green)
                .opacity(0.8)
                .font(.largeTitle)
                .fontWeight(.bold)
                .offset(y:250)
        }
        .frame(width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height)
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $sharedata.nextView) {
            CountView()
        }
    }
    private func moveBord() {
//        while(leftBoxSize > 0 || topBoxSize > 0) {
            withAnimation(.linear(duration: 1)) {
                leftBoxSize = 0
                topBoxSize = 0
            }
//        }
    }
    private func buttonColor() {
//        while(buttonSize < 81) {
            withAnimation(.linear(duration: 1)) {
                buttonSize = 80
            }
//        }
        if(buttonSize == 80) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                sharedata.nextView = true
            }
        }
    }
    
}

#Preview {
    StartView()
}
