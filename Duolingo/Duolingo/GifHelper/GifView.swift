//
//  GifView.swift
//  Duolingo
//
//  Created by PC on 07/01/25.
//
import SwiftUI
import UniformTypeIdentifiers

struct GifView: View {
    enum GifType {
        case file(_ name:String)
        case asset(_ name:String)
    }
    
    private let gifType: GifType
    private var showTimeline: Bool = false

    @State private var gifImage: Image?
    @State private var cgImages: [CGImage] = []
    @State private var durations: [Double] = []
    @State private var currentIndex: Int? = nil
    
    @State private var isPaused: Bool = true
    
    init(gifType: GifType, showTimeline: Bool = false) {
        self.gifType = gifType
        self.showTimeline = showTimeline
    }

    var body: some View {
        VStack(spacing: 20) {
            if let currentIndex, currentIndex < self.cgImages.count {
                let image = Image(uiImage: .init(cgImage: self.cgImages[currentIndex]))
                image
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Oops!")
                    .foregroundStyle(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(.black))
            }
            
            if self.showTimeline {
                let images = self.cgImages.map({Image(uiImage: .init(cgImage: $0))})
                GifTimelineView(images: images, currentIndex: self.$currentIndex)
            }
        }
        .onChange(of: self.currentIndex) {
            guard let currentIndex = self.currentIndex else {return}
            guard !self.isPaused else {return}
            if currentIndex >= self.durations.count {return}
            let duration = self.durations[currentIndex]
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                self.updateIndex()
            })
        }
        .onAppear {
            switch self.gifType {
            case let .file(name):
                if let url = Bundle.main.url(forResource: name, withExtension: "gif") {
                    (self.cgImages, self.durations) = GifManager.gif(url: url)
                    self.currentIndex = 0
                }
            case let .asset(name):
                let asset = NSDataAsset(name: name)
                if let asset {
                    let gifData = asset.data
                    (self.cgImages, self.durations) = GifManager.gif(data: gifData)
                    self.currentIndex = 0
                }
            }
            self.playAndPause()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    private func updateIndex() {
        guard let currentIndex = self.currentIndex else {return}
        if currentIndex == (self.cgImages.count - 1) {
            self.currentIndex = 0
        } else {
            self.currentIndex = currentIndex + 1
        }
    }
    
    func save() {
        Task {
            await GifManager.saveGif(self.cgImages, durations: self.durations)
        }
    }
    
    func playAndPause() {
        if self.isPaused {
            self.isPaused = false
            self.updateIndex()
        } else {
            self.isPaused = true
        }
    }
    
    func crop() {
        var newCgImages: [CGImage] = []
        for cgImage in self.cgImages {
            let currentHeight = cgImage.height
            let currentWidth = cgImage.width

            guard let halvedImage = cgImage.cropping(to: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: currentWidth/2, height: currentHeight))) else {continue}
            
            newCgImages.append(halvedImage)
        }
        self.cgImages = newCgImages
    }
    
    func playbackSpeed(speed: Double) { // speed = 0.5 for 2X and 2 for 0.5X
        let newDurations = self.durations.map({$0*speed})
        self.durations = newDurations
    }
    
}

private struct GifTimelineView: View {
    let images: [Image]
    @Binding var currentIndex: Int?
    @State private var scrollPosition: Int?

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(0..<self.images.count, id: \.self) { index in
                    if index > 0 {
                        Divider()
                            .frame(width: 1.5)
                            .background(.gray)
                    }
                    
                    Button(action: {
                        self.currentIndex = index
                    }, label: {
                        self.images[index]
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .frame(maxHeight: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke((index == self.currentIndex) ? .red : .clear, lineWidth: 4)
                                    .padding(.all, 2)
                            )
                    })

                }
            }
            .scrollTargetLayout()
        }
        .onChange(of: self.currentIndex, initial: true) {
            withAnimation {
                self.scrollPosition = self.currentIndex
            }
        }
        .scrollPosition(id: self.$scrollPosition)
        .scrollIndicators(.hidden)
        .frame(height: 60)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 4).fill(.clear).stroke(.gray, style: .init(lineWidth: 3.0)))
    }
}
