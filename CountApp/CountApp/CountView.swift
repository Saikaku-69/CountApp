//
//  CountView.swift
//  CountApp
//
//  Created by cmStudent on 2024/07/29.
//

import SwiftUI

struct CountView: View {
    @ObservedObject var sharedata = ShareData()
    @AppStorage("totalcount") private var totalcount = 0
//    @AppStorage("count") private var count = 0
    @State var count:Int = 0
    
    @State var result: Bool = false
    @State var isMessage: Bool = false
    
    @State var imgSize1: CGFloat = 30
    @State var imgSize2: CGFloat = 30
    
    @State var angle1: CGFloat = 0
    @State var angle2: CGFloat = 0
    @State var isCF:Bool = true
    @State var isWait:Bool = false
    //
    private var goodPercentage: Double {
        return count > 0 ? Double(sharedata.countgood) / Double(count) : 0
    }
    
    private var badPercentage: Double {
        return count > 0 ? Double(sharedata.countbad) / Double(count) : 0
    }
    
    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
//                           startPoint: .leading,
//                           endPoint: .trailing
//            )
//            .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Button(action: {
                        totalcount = 0
                        count = 0
                        sharedata.countgood = 0
                        sharedata.countbad = 0
                    }) {
                        Text("リセット")
                    }
                    Spacer()
                    Button(action: {
                        sharedata.nextView = true
                    }) {
                        Text("Home")
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .background(Color.yellow)
                            .cornerRadius(15)
                    }
                    Spacer()
                    Button(action: {
                        result = true
                    }) {
                        Text("　結果")
                    }.alert(isPresented: $result) {
                        Alert(title: Text("アンケート結果"),
                              message: Text("\n今までの人数:\(totalcount)人\n\n今日の人数\(count)人"),
                              primaryButton: .default(Text("もっと見る"), action: {
                            sharedata.isGauge = true
                        }),
                              secondaryButton: .default(Text("OK"))
                        )}
                }.frame(width: UIScreen.main.bounds.width-50)
                    .padding(.bottom)
                Text("来場者集計アプリ").font(.largeTitle)
                
                //立体効果追加
                VStack {
                    Text("今までの来場者")
                        .padding(.vertical)
                    Text("\(totalcount)人")
                    
                    Text("今回の来場者")
                        .padding(.vertical)
                    Text("\(count)人")
                }
                .padding(.horizontal, 50)
                .padding(.bottom)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: .gray, radius:15, x: 5, y: 5)
                //立体効果追加終了
                
                Spacer()
                //ボタン
                HStack {
                    VStack {
                        Button(action: {
                            sharedata.countgood += 1
                            Counts()
                            totalcount += 1
                            Anitor()
                            isMessage = true
                            isWait = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                isMessage = false
                                Stop()
                                isWait = false
                            }
                        }) {
                            Image(systemName: "hand.thumbsup")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: imgSize1)
                                .rotationEffect(.degrees(angle1))
                        }
                        .disabled(isWait)
                        Text("\(Int(sharedata.countgood))").font(.title)
                            .padding(.vertical)
                    }
                    Spacer()
                    VStack {
                        Button(action: {
                            sharedata.countbad += 1
                            Counts()
                            totalcount += 1
                            Anitor1()
                            isMessage = true
                            isWait = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                isMessage = false
                                Stop()
                                isWait = false
                            }
                        }) {
                            Image(systemName: "hand.thumbsdown")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: imgSize2)
                                .rotationEffect(.degrees(angle2))
                        }
                        .disabled(isWait)
                        Text("\(Int(sharedata.countbad))").font(.title)
                            .padding(.vertical)
                    }
                }.frame(width:UIScreen.main.bounds.width/2)
                //HStack終了
                
                Spacer()
                
                VStack {
                    if isMessage {
                        Text("ご協力ありがとうございます！")
                    }
                }
                .frame(height:20)
                
                Spacer()
                ZStack {
                    //
                    Rectangle()
                        .stroke(.gray)
                        .frame(width: 180, height: 30)
                    
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: CGFloat(goodPercentage) * 180, height: 30)
                        
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: CGFloat(badPercentage) * 180, height: 30)
                    }
                }
                HStack {
                    Rectangle()
                        .fill(.green)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10)
                    Text("よかった")
                    Rectangle()
                        .fill(.red)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10)
                    Text("悪かった")
                }
                
                Spacer()
                Text("簡単アンケート")
                    .padding(.vertical)
                
                
                //広告
                ZStack {
                    Button(action: {
                        sharedata.isSheet = true
                    }) {
                        if isCF {
                            ZStack {
                                Rectangle().stroke(.gray)
                                    .frame(width: 300,height: 50)
                                Image("jecimg")
                                    .resizable()
                                    .frame(width: 280,height: 50)
                            }
                        }
                    }
                    .sheet(isPresented: $sharedata.isSheet) {
                        AdView()
                    }
                    
                    Button(action: {
                        isCF = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            isCF = true
                        }
                    }) {
                        if isCF {
                            Image(systemName: "xmark.circle")
                                .font(.system(size: 20))
                                .background(.white)
                        }
                    }
                    .position(x: 330, y: 10)
                }
                .frame(height:20)
            }
//        }
        .fullScreenCover(isPresented: $sharedata.nextView) {
            StartView()
        }
        .fullScreenCover(isPresented: $sharedata.isGauge) {
            graphView(sharedata: sharedata)
        }
    }
    private func Counts() {
        count = Int(sharedata.countgood) + Int(sharedata.countbad)
    }
    
    private func Anitor() {
        withAnimation(.easeInOut(duration: 0.2).repeatForever(autoreverses: true)) {
            angle1 -= 45
        }
    }
    private func Anitor1() {
        withAnimation(.easeInOut(duration: 0.2).repeatForever(autoreverses: true)) {
            angle2 -= 45
        }
    }
    private func Stop() {
        withAnimation(.easeInOut(duration: 0.2)) {
            angle1 = 0
            angle2 = 0
        }
    }
}

#Preview {
    CountView()
}
