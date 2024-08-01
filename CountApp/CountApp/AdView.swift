//
//  AdView.swift
//  CountApp
//
//  Created by cmStudent on 2024/08/01.
//

import SwiftUI

struct AdView: View {
    @ObservedObject var sharedata = ShareData()
    //keeper.x: 100,215,330
    //keeper.y: 190,340
    
    //new.x:90,190,290
    //new.y:250,130
    //正中间
    @State var Position: CGPoint = CGPoint(x: 190, y: 250)
    @State var ballPosition: CGPoint = CGPoint(x: 190, y: 600)
    
    //ballSize: Befor: 50, After: 50
    @State var ballSize: CGFloat = 100
    
    @State private var timer: Timer?
    @State private var gameTimer: Timer?
    @State var isStart:Bool = true
    
    @State var goalCount = 0
    @State var Fail = 0
    @State var isStop = false
    @State var isBallDisabled = false
    
    @State var TimeLimit:Int = 10
    @State var remainingTime:Int = 10
    //Stopした時の時間
    @State private var StoppedTiming: Date?
    @State private var pauseRemainingTime: Int = 0
    @State private var isGoal:Bool = false
    @State private var isFail:Bool = false
    @State private var isEnd:Bool = false
    @State private var isEndgame:Bool = false
    
    @State var Point:Int = 0
    var body: some View {
        ZStack {
            
            ZStack {
                Image("goal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 340)
                    .position(x:190, y:180)
                Image("keeper")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:80)
                    .position(Position)
                
                //スコア
                if !isStart {
                    Text("Score:\(Point)")
                        .fontWeight(.bold)
                        .offset(x: 0,y: 120)
                }
                
                Button(action: {
                    ballMove()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        stopKeeper()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        result()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                        keeperMove()
                        isGoal = false
                        isFail = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        resetGame()
                    }
                }) {
                    Image("ball")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:ballSize)
                        .position(ballPosition)
                }
                .disabled(isStop || isBallDisabled || isEndgame)
            }
            //結果と時間
            HStack {
                VStack {
                    Text("Goal:\(goalCount)")
                    Text("Fail:\(Fail)")
                        .foregroundColor(.red)
                }
                Spacer()
                Text("\(TimeLimit)")
                Spacer()
                
                //休憩＆再開
                ZStack {
                    if !sharedata.isRestart {
                        Button(action: {
                            if isStop {
                                keeperMove()
                                timelimit()
                            } else {
                                stopKeeper()
                                stopGameTimer()
                            }
                            isStop.toggle()
                        }) {
                            Text(isStop ? "開始" : "休憩")
                        }
                    }
                    if sharedata.isRestart {
                        Button(action: {
                            //Timer = true
                            isBallDisabled = false
                            sharedata.isRestart = false
                            TimeLimit = 10
                            timelimit()
                            isEnd = false
                            isEndgame = false
                            keeperMove()
                        }) {
                            Text("再開")
                        }
                    }
                }
                
                
            }
            .frame(width:UIScreen.main.bounds.width-50)
            .offset(y:-340)
            ZStack {
                if isGoal {
                    Text("GOAL")
                        .fontWeight(.bold)
                }
                if isFail {
                    Text("FAIL")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
            }
            //開始ボタン
            if isStart {
                Button(action: {
                    isStart = false
                    keeperMove()
                    timelimit()
                }) {
                    Text("START")
                        .padding()
                        .foregroundColor(.black)
                        .background(.yellow)
                        .fontWeight(.bold)
                        .cornerRadius(15)
                        .position(x:190, y:400)
                }
            }
            if isEnd {
                Text("END")
                    .padding()
                    .foregroundColor(.black)
                    .background(.red)
                    .fontWeight(.bold)
                    .cornerRadius(15)
                    .position(x:190, y:400)
                
            }
        }
    }
    
    private func stopKeeper() {
        // 停止计时器
        timer?.invalidate()
        timer = nil
    }
    
    private func keeperMove() {
        let positions: [CGPoint] = [
            CGPoint(x: 90, y: 250),
            CGPoint(x: 190, y: 250),
            CGPoint(x: 290, y: 250),
            CGPoint(x: 90, y: 130),
            CGPoint(x: 190, y: 130),
            CGPoint(x: 290, y: 130)
        ]
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            withAnimation {
                Position = positions.randomElement() ?? Position
            }
        }
    }
    
    private func ballMove() {
        let goal: [CGPoint] = [
            CGPoint(x: 90, y: 250),
            CGPoint(x: 190, y: 250),
            CGPoint(x: 290, y: 250),
            CGPoint(x: 90, y: 130),
            CGPoint(x: 190, y: 130),
            CGPoint(x: 290, y: 130)
        ]
        isBallDisabled = true
        withAnimation {
            ballPosition = goal.randomElement() ?? ballPosition
            ballSize -= 50
        }
    }
    private func result() {
        if Position == ballPosition {
            Fail += 1
            isFail = true
            Point -= 50
        } else {
            goalCount += 1
            isGoal = true
            Point += 100
        }
    }
    private func resetGame() {
        ballSize = 100
        ballPosition = CGPoint(x: 190, y: 600)
        isBallDisabled = false
    }
    private func timelimit() {
        //chatGPT
        if let StoppedTiming = StoppedTiming {
            let timeElapsed = Date().timeIntervalSince(StoppedTiming)
            remainingTime = max(0, pauseRemainingTime - Int(timeElapsed))
        } else {
            remainingTime = TimeLimit
        }
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if(remainingTime > 0) {
                remainingTime -= 1
                TimeLimit = remainingTime
            } else {
                gameTimer?.invalidate()
                gameTimer = nil
                isEnd = true
            }
            if(remainingTime == 0) {
                stopKeeper()
                withAnimation {
                    Position = CGPoint(x: 190, y: 250)
                }
                sharedata.isRestart = true
                endGame()
            }
        }
    }
    private func stopGameTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
    }
    private func endGame() {
        isEndgame = true
    }
}

#Preview {
    AdView()
}
