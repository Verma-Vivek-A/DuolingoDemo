//
//  DepthButtonStyle.swift
//  Duolingo
//
//  Created by PC on 06/01/25.
//

import SwiftUI

struct DepthButtonStyle: ButtonStyle {
    
    private enum Shape {
        case rectangle
        case ellipse
    }
    
    private var shape: Shape
    private var foregroundColor: Color
    private var backgroundColor: Color
    private var cornerRadius: CGFloat
    private let lineWidth: CGFloat
    private var yOffset: CGFloat {
        self.shape == .rectangle ? 4 : 8
    }
    
    init(foregroundColor: Color, backgroundColor: Color, cornerRadius: CGFloat = 0, lineWidth: CGFloat = 0) {
        self.shape = .rectangle
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.lineWidth = lineWidth
    }
    
    init(foregroundColor: Color, backgroundColor: Color, lineWidth: CGFloat = 0) {
        self.shape = .ellipse
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = 0
        self.lineWidth = lineWidth
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            self.buttonShape(color: self.backgroundColor, strokeColor: self.backgroundColor)
            self.buttonShape(color: self.foregroundColor, strokeColor: self.backgroundColor)
                .offset(y: configuration.isPressed ? 0 : -self.yOffset)
            configuration.label
                .foregroundStyle(self.backgroundColor)
                .offset(y: -self.yOffset)
                .offset(y: configuration.isPressed ? self.yOffset : 0)
                .sensoryFeedback(
                    configuration.isPressed
                    ? .impact(flexibility: .soft, intensity: 0.75)
                    : .impact(flexibility: .solid),
                    trigger: configuration.isPressed
                )
        }
    }
    
    @ViewBuilder
    private func buttonShape(color: Color, strokeColor: Color) -> some View {
        switch self.shape {
        case .rectangle:
            RoundedRectangle(cornerRadius: self.cornerRadius).fill(color).stroke(strokeColor, lineWidth: self.lineWidth)
        case .ellipse:
            Ellipse().fill(color).stroke(strokeColor, lineWidth: self.lineWidth)
        }
    }
    
}
