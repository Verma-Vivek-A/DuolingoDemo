//
//  GetStartedView.swift
//  Duolingo
//
//  Created by PC on 06/01/25.
//

import SwiftUI

struct GetStartedView: View {
    
    @EnvironmentObject var navigationState: NavigationState
    
    var body: some View {
        VStack(spacing: 24) {
            
            Spacer()
            
            GifView(gifType: .file("duoGreating"))
                    .frame(height: 200)
                    .padding(.leading, 40)
         
            Text("duolingo")
                .kerning(1.5)
                .fontWeight(.heavy)
                .font(.system(size: 42))
                .foregroundStyle(COLOR.primaryGreen)
            
            Text("Learn for free. Forever")
                .kerning(1.1)
                .font(.system(size: 22))
                .foregroundStyle(.white)
            
            Spacer()
            Spacer()
            
            Button {
                self.navigationState.push(route: .onboarding)
            } label: {
                Text("GET STARTED")
                    .kerning(1.1)
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                    .foregroundStyle(.black)
            }
            .buttonStyle(DepthButtonStyle(foregroundColor: COLOR.primaryGreen, backgroundColor: COLOR.secondaryGreen, cornerRadius: 16))
            .frame(height: 50)
            
            Button {
                self.navigationState.setRoot(to: .home)
            } label: {
                Text("I ALREADY HAVE AN ACCOUNT")
                    .kerning(1.1)
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                    .foregroundStyle(COLOR.primaryGreen)
            }
            .buttonStyle(DepthButtonStyle(foregroundColor: .black, backgroundColor: COLOR.gray, cornerRadius: 16, lineWidth: 1))
            .frame(height: 50)
        }
        .padding()
        .background(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationDestination(for: NavigationRoute.self) { route in
            NavigationRouteView(route: route)
        }
    }
    
}

#Preview {
    GetStartedView()
}
