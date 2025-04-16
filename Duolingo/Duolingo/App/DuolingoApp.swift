//
//  DuolingoApp.swift
//  Duolingo
//
//  Created by PC on 06/01/25.
//

import SwiftUI

@main
struct DuolingoApp: App {
    
    @ObservedObject private var navigationState = NavigationState()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: self.$navigationState.path) {
                switch self.navigationState.currentRoot {
                    
                case .getStarted:
                    GetStartedView()
                    
                case .home:
                    HomeView()
                    
                }
            }
            .preferredColorScheme(.light)
        }
        .environmentObject(self.navigationState)
    }
}
