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
}
