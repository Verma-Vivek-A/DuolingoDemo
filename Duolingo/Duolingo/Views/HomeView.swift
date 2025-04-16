//
//  ContentView.swift
//  Duolingo
//
//  Created by PC on 06/01/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showScrollToTopButton = false
    @State private var currentSyllabus: Syllabus = Syllabus.data[0]

    private let data = Syllabus.data
    private let scrollThreshold: CGFloat = 200
    private let currentSyllabusThreshold: CGFloat = 150
    
    private let xOffsets: [CGFloat] = [0, -60, -90, -60, 0]
    private let icons: [String] = ["star.fill",  "dumbbell.fill", "forward.fill", "star.fill", "bubbles.and.sparkles.fill"]
    
    var body: some View {
        VStack(spacing: 20) {
            
            HeaderView()
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 40) {
                        ForEach(self.data, id: \.id) { item in
                            VStack(spacing: 40) {
                                
                                TitleView(item: item)
                                
                                ForEach(0..<self.xOffsets.count, id: \.self) { index in
                                    LazyVStack(spacing: 30) {
                                        EllipseButton(image: self.icons[index], foregroundColor: item.foregroundColor, backgroundColor: item.backgroundColor)
                                            .offset(x: self.xOffsets[index])
                                    }
                                    .background(
                                        GeometryReader { geometry in
                                            Color.clear
                                                .onChange(of: geometry.frame(in: .global)) { _, _ in
                                                    self.updateCurrentSection(geometry: geometry, syllabus: item)
                                                }
                                        }
                                    )
                                }
                                
                            }
                        }
                        
                        RectangleButton(text: "Next")
                    }
                    .padding(.top, 100)
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    self.trackScrollPosition(proxy: proxy)
                                }
                                .onChange(of: proxy.frame(in: .global).minY) { _ , _ in
                                    self.trackScrollPosition(proxy: proxy)
                                }
                        }
                    )
                    
                }
                .overlay(alignment: .top) {
                    OverlayView()
                }
                .overlay(alignment: .bottomTrailing) {
                    if self.showScrollToTopButton {
                        ScrollToTopView(proxy: proxy)
                    }
                }
            }
            
        }
        .clipped()
        .padding(.horizontal, 5)
        .background(Color.black.ignoresSafeArea())
    }
    
    @ViewBuilder
    private func HeaderView() -> some View {
        HStack {
            Text("🇮🇳 96")
            Spacer()
            Text("🔥 1")
            Spacer()
            Text("💎 550")
            Spacer()
            Text("❤️ 5")
        }
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(.white)
    }
    
    @ViewBuilder
    private func TitleView(item: Syllabus) -> some View {
        HStack {
            Rectangle()
                .fill(COLOR.gray)
                .frame(height: 1)
            
            Text(item.title)
                .lineLimit(1)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(COLOR.gray)
                .layoutPriority(1)
            
            Rectangle()
                .fill(COLOR.gray)
                .frame(height: 1)
                .frame(maxWidth: .infinity)
        }
        .id(item.id)
        .fixedSize(horizontal: false, vertical: false)
    }
    
    @ViewBuilder
    private func EllipseButton(image: String, foregroundColor: Color, backgroundColor: Color) -> some View {
        Button {
            
        } label: {
            Image(systemName: image)
                .resizable()
                .frame(width: 30, height: 30)
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.white)
        }
        .buttonStyle(DepthButtonStyle(foregroundColor: foregroundColor, backgroundColor: backgroundColor))
        .frame(width: 80, height: 70)
    }
    
    @ViewBuilder
    private func RectangleButton(text: String) -> some View {
        Button {
            
        } label: {
            Text(text)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
        .buttonStyle(DepthButtonStyle(foregroundColor: COLOR.primaryBlue, backgroundColor: COLOR.secondaryBlue, cornerRadius: 16))
        .frame(maxWidth: .infinity)
        .frame(height: 50)
    }
    
    @ViewBuilder
    private func OverlayView() -> some View {
        Button {
            
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(self.currentSyllabus.section)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white.opacity(0.6))
                    
                    Text(self.currentSyllabus.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                
                Rectangle()
                    .frame(width: 2)
                
                Image("notebook")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
            }
        }
        .buttonStyle(DepthButtonStyle(foregroundColor: self.currentSyllabus.foregroundColor, backgroundColor: self.currentSyllabus.backgroundColor, cornerRadius: 16))
        .fixedSize(horizontal: false, vertical: true)
    }
 
    @ViewBuilder
    private func ScrollToTopView(proxy: ScrollViewProxy) -> some View {
        Button {
            withAnimation {
                proxy.scrollTo(self.data[0].id, anchor: .top)
            }
        } label: {
            Image("up_arrow")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(12)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.black)
                .strokeBorder(COLOR.gray, lineWidth: 2)
        )
    }
    
    private func updateCurrentSection(geometry: GeometryProxy, syllabus: Syllabus) {
        let frame = geometry.frame(in: .global)
        let isVisible = frame.maxY > self.currentSyllabusThreshold
        if isVisible {
            DispatchQueue.main.async {
                self.currentSyllabus = syllabus
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            }
        }
    }
 
    private func trackScrollPosition(proxy: GeometryProxy) {
        let scrollPosition = -proxy.frame(in: .global).minY
        if scrollPosition > self.scrollThreshold {
            if !self.showScrollToTopButton {
                withAnimation {
                    self.showScrollToTopButton = true
                }
            }
        } else {
            if self.showScrollToTopButton {
                withAnimation {
                    self.showScrollToTopButton = false
                }
            }
        }
    }
    
}

#Preview {
    HomeView()
}
