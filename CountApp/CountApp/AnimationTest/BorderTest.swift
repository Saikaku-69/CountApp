//
//  BorderTest.swift
//  CountApp
//
//  Created by cmStudent on 2024/08/02.
//

import SwiftUI

struct BorderTest: View {
    var body: some View {
        VStack {
            Text("Hello, SwiftUI!")
                .font(.largeTitle)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
//                .shadow(color: .red,radius: 10,x:15,y:15)
            
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 100, height: 100)
//                .shadow(color: .black, radius: 10, x: 5, y: 5)
        }
//        .background(.white)
//        .shadow(color: .gray,radius: 10)
//        .padding()
//        .background(Color(.systemGray6))
    }
}

#Preview {
    BorderTest()
}
