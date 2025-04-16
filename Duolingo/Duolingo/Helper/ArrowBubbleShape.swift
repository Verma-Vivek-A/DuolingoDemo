//
//  BubbleWithArrow.swift
//  Duolingo
//
//  Created by PC on 07/01/25.
//

import SwiftUI

struct LeadingArrowBubble: Shape {
    
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 16
        let arrowWidth: CGFloat = 20
        let arrowHeight: CGFloat = 10
        
        return Path { path in
            // Start at the top-left corner
            path.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
            
            // Top-right corner
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
            path.addArc(
                center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(-90),
                endAngle: .degrees(0),
                clockwise: false
            )
            
            // Right side
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            path.addArc(
                center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: false
            )
            
            // Bottom-right corner
            path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
            path.addArc(
                center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
            // Left side with centered arrow
            let arrowStartY = rect.midY - arrowWidth / 2
            let arrowEndY = rect.midY + arrowWidth / 2
            
            path.addLine(to: CGPoint(x: rect.minX, y: arrowEndY)) // Bottom of arrow base
            path.addLine(to: CGPoint(x: rect.minX - arrowHeight, y: rect.midY)) // Arrow tip
            path.addLine(to: CGPoint(x: rect.minX, y: arrowStartY)) // Top of arrow base
            
            // Complete the path
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
            path.addArc(
                center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
        }
    }
}

struct TrailingArrowBubble: Shape {
    
    func path(in rect: CGRect) -> Path {
            let cornerRadius: CGFloat = 16
            let arrowWidth: CGFloat = 20
            let arrowHeight: CGFloat = 10
            
            return Path { path in
                // Start at the top-left corner
                path.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
                
                // Top-left corner
                path.addLine(to: CGPoint(x: rect.maxX - cornerRadius - arrowHeight, y: rect.minY))
                path.addArc(
                    center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: .degrees(-90),
                    endAngle: .degrees(0),
                    clockwise: false
                )
                
                // Right side with centered arrow
                let arrowStartY = rect.midY + arrowWidth / 2
                let arrowEndY = rect.midY - arrowWidth / 2
                
                path.addLine(to: CGPoint(x: rect.maxX, y: arrowEndY)) // Bottom of arrow base
                path.addLine(to: CGPoint(x: rect.maxX + arrowHeight, y: rect.midY)) // Arrow tip
                path.addLine(to: CGPoint(x: rect.maxX, y: arrowStartY)) // Top of arrow base
                
                // Bottom-right corner
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
                path.addArc(
                    center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: .degrees(0),
                    endAngle: .degrees(90),
                    clockwise: false
                )
                
                // Bottom side
                path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
                path.addArc(
                    center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: .degrees(90),
                    endAngle: .degrees(180),
                    clockwise: false
                )
                
                // Left side
                path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
                path.addArc(
                    center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: .degrees(180),
                    endAngle: .degrees(270),
                    clockwise: false
                )
            }
        }
}

struct BottomArrowBubble: Shape {
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 16
        let arrowWidth: CGFloat = 20
        let arrowHeight: CGFloat = 10
        
        return Path { path in
            // Start at the top-left corner
            path.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
            
            // Top-right corner
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
            path.addArc(
                center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(-90),
                endAngle: .degrees(0),
                clockwise: false
            )
            
            // Right side
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - arrowHeight - cornerRadius))
            path.addArc(
                center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - arrowHeight - cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: false
            )
            
            // Bottom edge with arrow
            path.addLine(to: CGPoint(x: rect.midX + arrowWidth / 2, y: rect.maxY - arrowHeight))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY)) // Arrow tip
            path.addLine(to: CGPoint(x: rect.midX - arrowWidth / 2, y: rect.maxY - arrowHeight))
            
            // Bottom-left corner
            path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - arrowHeight))
            path.addArc(
                center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - arrowHeight - cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
            // Left side
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
            path.addArc(
                center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
        }
    }
}

struct TopArrowBubble: Shape {
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 16
        let arrowWidth: CGFloat = 20
        let arrowHeight: CGFloat = 10
        
        return Path { path in
            // Start at the top-left corner
            path.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))

            // Arrow
            path.addLine(to: CGPoint(x: rect.midX - arrowWidth / 2, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY - arrowHeight))
            path.addLine(to: CGPoint(x: rect.midX + arrowWidth / 2, y: rect.minY))
            
            // Top-right corner
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
            path.addArc(
                center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(-90),
                endAngle: .degrees(0),
                clockwise: false
            )
            
            // Right side
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - arrowHeight - cornerRadius))
            path.addArc(
                center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - arrowHeight - cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: false
            )
            
            // Bottom-left corner
            path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - arrowHeight))
            path.addArc(
                center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - arrowHeight - cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
            // Left side
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
            path.addArc(
                center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
        }
    }
}
