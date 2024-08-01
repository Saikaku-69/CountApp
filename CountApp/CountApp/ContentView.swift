////
////  ContentView.swift
////  CountApp
////
////  Created by cmStudent on 2024/07/29.
////
//
//import SwiftUI
//
//struct Str: Identifiable {
//    let id = UUID()
//    let str: String
//    var num: Int
//    
//    init(str: String, num: Int) {
//        self.str = str
//        self.num = num
//    }
//}
//
//struct ContentView: View {
//    
//    @AppStorage("totalcount") private var totalcount = 0
//    
//    
//    @State var str = [
//        Str(str: "前日までの来場者", num: 0)
//    ]
//    
//    @State var countgood = 0
//    @State var countsoso = 0
//    
//    
//    var body: some View {
//        
//        VStack {
//            Text("来場者集計アプリ").font(.largeTitle)
//            
//            VStack {
//                ForEach($str) { $name in
//                    Text(name.str)
//                    Text("\(totalcount)人")
//                }
//                .padding(.vertical)
//                
//                Text("本日の来場者")
//                Text("\(countgood + countsoso)人")
//                    .padding(.vertical)
//            }
//            
//            Spacer()
//            
//            HStack {
//                VStack {
//                    Text("Good")
//                    Text("\(countgood)")
//                }
//                Spacer()
//                VStack {
//                    Text("Soso")
//                    Text("\(countsoso)")
//                }
//            }
//            
//            Spacer()
//            Text("簡単アンケート")
//            
//            
//            HStack {
//                
//                Button(action: {
//                    countgood += 1
//                    updateTotalCount()
//                }) {
//                    Text("よかった！")
//                }
//                
//                Button(action: {
//                    countsoso += 1
//                    updateTotalCount()
//                }) {
//                    Text("まあまあ")
//                }
//            }
//        }
//    }
//    
//    private func updateTotalCount() {
//        totalcount = countgood + countsoso
//        str[0].num = totalcount
//    }
//}
//
//#Preview {
//    ContentView()
//}
