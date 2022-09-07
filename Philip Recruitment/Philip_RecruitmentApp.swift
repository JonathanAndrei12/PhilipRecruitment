//
//  Philip_RecruitmentApp.swift
//  Philip Recruitment
//
//  Created by Jonathan Andrei on 06/09/22.
//

import SwiftUI

@main
struct Philip_RecruitmentApp: App {
    init() {
        autoFillStock()
    }
    
    var body: some Scene {
        WindowGroup {
            RunningTradeView()
        }
    }
}
