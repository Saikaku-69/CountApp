//
//  shareData.swift
//  CountApp
//
//  Created by cmStudent on 2024/08/01.
//

import Foundation

class ShareData:ObservableObject {
    @Published var isSheet:Bool = false
    @Published var isRestart:Bool = false
    @Published var countgood:Double = 0.0
    @Published var countbad:Double = 0.0
    //画面の切り替え
    @Published var nextView: Bool = false
    //GaugeView
    @Published var isGauge: Bool = false
}
