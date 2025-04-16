//
//  ThoughtBubbleView.swift
//  Duolingo
//
//  Created by PC on 06/01/25.
//

import SwiftUI

struct ThoughtBubbleView: View {
    var text: AttributedString
    var direction: Edge.Set = .leading
    var lineWidth: Double = 1.0
    
    private let typingSpeed = 0.1
    @State private var typingIndex = 0
    @State private var fullText = AttributedString()
    @State private var currentText = AttributedString()
    
    init(text: AttributedString, direction: Edge.Set = .leading, lineWidth: Double = 1.0) {
        self.text = text
        self.direction = direction
        self.lineWidth = lineWidth
    }
    
    private var directionalPadding: Double {
        if (self.direction == .top || self.direction == .bottom) {
            return 10
        }
        return 0
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                if self.direction == .top {
                    TopArrowBubble()
                        .stroke(COLOR.gray, lineWidth: self.lineWidth)
                } else if self.direction == .leading {
                    LeadingArrowBubble()
                        .stroke(COLOR.gray, lineWidth: self.lineWidth)
                } else if self.direction == .bottom {
                    BottomArrowBubble()
                        .stroke(COLOR.gray, lineWidth: self.lineWidth)
                } else if self.direction == .trailing {
                    TrailingArrowBubble()
                        .stroke(COLOR.gray, lineWidth: self.lineWidth)
                }

                Text(self.currentText)
                    .padding(15)
                    .kerning(1.1)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16, weight: .bold))
                    .padding(.bottom, self.directionalPadding)
                    .contentTransition(.numericText())
            }
            .fixedSize(horizontal: true, vertical: true) // Ensure dynamic size based on content
            .padding(16)
        }
        .onChange(of: self.text, { _, _ in
            self.startTypingAnimation()
        })
        .onAppear {
            self.startTypingAnimation()
        }
    }
    
    func startTypingAnimation() {
        self.typingIndex = 0
        self.fullText = self.text
        self.currentText = AttributedString("")
        
        Timer.scheduledTimer(withTimeInterval: self.typingSpeed, repeats: true) { timer in
            guard self.typingIndex < self.fullText.characters.count else {
                timer.invalidate() // Stop when all characters are revealed
                return
            }
            
            // Incrementally reveal each character
            let index = self.fullText.characters.index(self.fullText.startIndex, offsetBy: self.typingIndex)
            withAnimation {
                self.currentText.append(self.fullText[index...index])
            }
            self.typingIndex += 1
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            ThoughtBubbleView(text: "Hello", direction: .top)
            ThoughtBubbleView(text: "Hello", direction: .leading)
            ThoughtBubbleView(text: "Hello", direction: .bottom)
            ThoughtBubbleView(text: "Hello", direction: .trailing)
        }
    }
}
