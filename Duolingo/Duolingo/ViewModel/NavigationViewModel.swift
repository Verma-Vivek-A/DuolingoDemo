//
//  NavigationViewModel.swift
//  Duolingo
//
//  Created by PC on 06/01/25.
//

import Foundation
import SwiftUI

enum NavigationRoute: Hashable {
    case onboarding
    case home
}

class NavigationState: ObservableObject {
    
    enum NavigationRoot: Hashable {
        case getStarted
        case home
    }
    
    @Published var path = NavigationPath()
    @Published var currentRoot: NavigationRoot = {
        return .getStarted
    }()
    
    func push(route: NavigationRoute) {
        self.path.append(route)
    }
    
    func pop() {
        guard !self.path.isEmpty else { return }
        self.path.removeLast()
    }
    
    func popToRoot() {
        self.path.removeLast(self.path.count)
    }
    
    func setRoot(to root: NavigationRoot) {
        self.popToRoot()
        self.currentRoot = root
    }
    
}

struct NavigationRouteView: View {
    
    var route: NavigationRoute
    
    var body: some View {
        switch route {
            
        case .onboarding:
            OnboardingView()
            
        case .home:
            HomeView()
            
        }
    }
    
}
