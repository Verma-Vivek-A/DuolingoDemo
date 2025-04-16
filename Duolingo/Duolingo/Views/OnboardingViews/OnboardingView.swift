//
//  OnboardingView.swift
//  Duolingo
//
//  Created by PC on 06/01/25.
//

import SwiftUI

struct OnboardingView: View {
    
    private let data = Onboarding.data
    
    @Namespace private var animation
    @Namespace private var gifView
    @Namespace private var message
    
    @State private var progress: CGFloat = 0
    @State private var currentIndex: Int = 0
    @State private var hearAboutUsIndex: Int?
    @State private var englishKnowledgeIndex: Int?
    @State private var learningEnglishIndex: Int?
    @State private var dailyLearningGoalIndex: Int?
    
    @State private var animationTimer: Timer?
    @State private var isArrowMoving = false
    
    @EnvironmentObject var navigationState: NavigationState
    
    var body: some View {
        VStack {
            
            if self.currentIndex < 2 || 13..<15 ~= self.currentIndex {
                self.ExpandedView()
            } else if self.currentIndex == 3  {
                self.CreatingCourseView(title: "COURSE BUILDING...")
            } else if self.currentIndex == 15  {
                self.CreatingCourseView(title: "LOADING...")
            } else {
                CustomSlider(value: self.$progress, range: 0...CGFloat(self.data.count), config: .init(activeTint: COLOR.primaryGreen, inActiveTint: COLOR.gray, isGestureActive: false)) { }
                self.CollaspedView()
                    .padding(.horizontal)
            }
            
            if self.currentIndex == 2 {
                SelectLanguageView()
                    .padding()
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
            } else if self.currentIndex == 4 {
                HearAboutUsView()
                    .padding()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if self.currentIndex == 5 {
                EnglishKnowledgeView()
                    .padding()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if self.currentIndex == 7 {
                LearningEnglishView()
                    .padding()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if self.currentIndex == 9 {
                DailyLearningGoalView()
                    .padding()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if self.currentIndex == 11 {
                Spacer()
                NotificationView()
                    .transition(.opacity)
            } else if self.currentIndex == 12 {
                AchieveView()
            }
            
            Spacer()
            
            Button {
                if self.currentIndex < (self.data.count - 1) {
                    withAnimation {
                        self.currentIndex += 1
                        self.progress = CGFloat(self.currentIndex + 1)
                    }
                } else {
                    self.navigationState.setRoot(to: .home)
                }
            } label: {
                Text("CONTINUE")
                    .kerning(1.1)
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                    .foregroundStyle(.black)
            }
            .buttonStyle(DepthButtonStyle(foregroundColor: COLOR.primaryGreen, backgroundColor: COLOR.secondaryGreen, cornerRadius: 16))
            .frame(height: 50)
            .padding()
            
        }
        .background(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func ExpandedView() -> some View {
        Spacer()
        
        ThoughtBubbleView(text: self.data[self.currentIndex].message, direction: .bottom)
            .matchedGeometryEffect(id: self.message, in: self.animation)
        
        GifView(gifType: .file("duoGreating"))
            .matchedGeometryEffect(id: self.gifView, in: self.animation)
            .frame(height: 200)
            .padding(.leading, 40)
            .padding(.vertical, -40)
    }
    
    @ViewBuilder
    private func CollaspedView() -> some View {
        HStack {
            GifView(gifType: .file("duoGreating"))
                .matchedGeometryEffect(id: self.gifView, in: self.animation)
                .frame(width: 150, height: 100)
                .padding(.horizontal, -30)
            
            ThoughtBubbleView(text: self.data[self.currentIndex].message)
                .matchedGeometryEffect(id: self.message, in: self.animation)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func CreatingCourseView(title: String) -> some View {
        Spacer()
        
        GifView(gifType: .file("duoSinging"))
            .matchedGeometryEffect(id: self.gifView, in: self.animation)
            .frame(height: 200)
        
        Text(title)
            .kerning(1.1)
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(COLOR.gray)
            .padding()
        
        Text(self.data[self.currentIndex].message)
            .lineSpacing(8)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .font(.system(size: 20))
    }
    
    @ViewBuilder
    private func HearAboutUsView() -> some View {
        ScrollView {
            ForEach(Constants.hearAboutUs.indices, id: \.self) { index in
                Button {
                    self.englishKnowledgeIndex = index
                } label: {
                    HStack {
                        Text(Constants.hearAboutUs[index])
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(self.englishKnowledgeIndex == index ? COLOR.primaryBlue : .white)
                        Spacer()
                    }
                    .padding(15)
                }
                .buttonStyle(DepthButtonStyle(foregroundColor: .black, backgroundColor: self.englishKnowledgeIndex == index ? COLOR.primaryBlue : COLOR.gray, cornerRadius: 16, lineWidth: 1))
                .padding(.vertical, 5)
            }
        }
    }
    
    @ViewBuilder
    private func EnglishKnowledgeView() -> some View {
        ScrollView {
            ForEach(Constants.englishKnowledge.indices, id: \.self) { index in
                Button {
                    self.hearAboutUsIndex = index
                } label: {
                    HStack {
                        HStack(alignment: .bottom, spacing: 4) {
                            Rectangle()
                                .fill(index <= 0 ? .white : COLOR.primaryBlue)
                                .frame(width: 5, height: 10)
                            Rectangle()
                                .fill(index <= 1 ? .white : COLOR.primaryBlue)
                                .frame(width: 5, height: 15)
                            Rectangle()
                                .fill(index <= 2 ? .white : COLOR.primaryBlue)
                                .frame(width: 5, height: 20)
                            Rectangle()
                                .fill(index <= 3 ? .white : COLOR.primaryBlue)
                                .frame(width: 5, height: 25)
                        }
                        .padding(.trailing, 5)
                        
                        Text(Constants.englishKnowledge[index])
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(self.hearAboutUsIndex == index ? COLOR.primaryBlue : .white)
                    }
                    .padding(15)
                }
                .buttonStyle(DepthButtonStyle(foregroundColor: .black, backgroundColor: self.hearAboutUsIndex == index ? COLOR.primaryBlue : COLOR.gray, cornerRadius: 16, lineWidth: 1))
                .padding(.vertical, 5)
            }
        }
    }
    
    @ViewBuilder
    private func LearningEnglishView() -> some View {
        ScrollView {
            ForEach(Constants.learningEnglish.indices, id: \.self) { index in
                Button {
                    self.learningEnglishIndex = index
                } label: {
                    HStack {
                        Text(Constants.learningEnglish[index])
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(self.learningEnglishIndex == index ? COLOR.primaryBlue : .white)
                    }
                    .padding(15)
                }
                .buttonStyle(DepthButtonStyle(foregroundColor: .black, backgroundColor: self.learningEnglishIndex == index ? COLOR.primaryBlue : COLOR.gray, cornerRadius: 16, lineWidth: 1))
                .padding(.vertical, 5)
            }
        }
    }
    
    @ViewBuilder
    private func DailyLearningGoalView() -> some View {
        ScrollView {
            ForEach(0..<Constants.dailyLearningGoal.count, id: \.self) { index in
                Button {
                    self.dailyLearningGoalIndex = index
                } label: {
                    HStack {
                        let dailyGoal = Constants.dailyLearningGoal[index]
                        Text(dailyGoal.time)
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(dailyGoal.type)
                            .fontWeight(.medium)
                    }
                    .padding(15)
                    .foregroundStyle(self.dailyLearningGoalIndex == index ? COLOR.primaryBlue : .white)
                }
                .buttonStyle(DepthButtonStyle(foregroundColor: .black, backgroundColor: self.dailyLearningGoalIndex == index ? COLOR.primaryBlue : COLOR.gray, cornerRadius: 16, lineWidth: 1))
                .padding(.vertical, 5)
            }
        }
    }
    
    @ViewBuilder
    private func NotificationView() -> some View {
        VStack(spacing: 0) {
            VStack(spacing: 10) {
                Text("\"**Duolingo**\" Would Like to Send You Notifications")
                    .font(.title2)
                    .foregroundStyle(COLOR.gray)
                    .multilineTextAlignment(.center)
                
                Text("Notifications may include alerts, sounds and icon badges. Thses can be configured in Settings.")
                    .font(.callout)
                    .foregroundStyle(COLOR.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()
            
            Rectangle()
                .fill(COLOR.gray)
                .frame(height: 1)
            
            HStack {
                Text("Don't Allow")
                    .font(.title2)
                    .foregroundStyle(COLOR.gray)
                    .frame(maxWidth: .infinity)
                
                Rectangle()
                    .fill(COLOR.gray)
                    .frame(width: 1)
                
                Text("Allow")
                    .font(.title2)
                    .foregroundStyle(COLOR.primaryBlue)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 50)
        }
        .frame(width: 340)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .stroke(COLOR.gray, lineWidth: 1)
        }
        
        HStack {
            Spacer()
                .frame(maxWidth: .infinity)
            Image("up_arrow")
                .resizable()
                .frame(width: 30, height: 35)
                .frame(maxWidth: .infinity)
                .offset(y: self.isArrowMoving ? -20 : 0)
                .animation(.easeInOut(duration: 1), value: self.isArrowMoving)
                .onAppear {
                    self.animationTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        self.isArrowMoving.toggle()
                    }
                }
                .onDisappear {
                    self.animationTimer?.invalidate()
                }
        }
        .padding(.vertical)
        .frame(width: 340)
    }
    
    @ViewBuilder
    private func AchieveView() -> some View {
        ScrollView {
            ForEach(0..<Constants.achieve.count, id: \.self) { index in
                VStack(alignment: .leading) {
                    let achieve = Constants.achieve[index]
                    Text(achieve.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(achieve.description)
                        .fontWeight(.medium)
                        .foregroundStyle(COLOR.gray)
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(self.dailyLearningGoalIndex == index ? COLOR.primaryBlue : .white)
            }
        }
    }
    
}

#Preview {
    OnboardingView()
}

