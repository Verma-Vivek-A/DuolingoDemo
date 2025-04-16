//
//  CustomSlider.swift
//  Duolingo
//
//  Created by PC on 10/01/25.
//

import SwiftUI

struct CustomSlider<Overlay: View>: View {
    
    @Binding var value: CGFloat
    var range: ClosedRange<CGFloat>
    var config: Config
    var overlay: Overlay
    
    init(value: Binding<CGFloat>, range: ClosedRange<CGFloat>, config: Config = .init(),  @ViewBuilder overlay: @escaping () -> Overlay) {
        self._value = value
        self.range = range
        self.config = config
        self.overlay = overlay()
        self.lastStoredValue = value.wrappedValue
    }
    
    struct Config {
        var activeTint: Color = Color.primary
        var inActiveTint: Color = Color.black.opacity(0.06)
        
        var height: CGFloat = 20
        var extraHeight: CGFloat = 15
        var cornerRadius: CGFloat = 15
        var isGestureActive: Bool = true
        
        var overlayActiveTint: Color = .white
        var overlayInActiveTint: Color = .black
    }
    
    @State private var lastStoredValue: CGFloat = 0
    @GestureState private var isActive: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let width = (self.value / self.range.upperBound) * size.width
            
            ZStack {
                Rectangle()
                    .fill(self.config.inActiveTint)
                
                Rectangle()
                    .fill(self.config.activeTint)
                    .overlay(alignment: .top) {
                        Rectangle()
                            .fill(.white.opacity(0.5))
                            .frame(height: 4)
                            .padding(size.height * 0.35)
                    }
                    .mask(alignment: .leading) {
                        Rectangle()
                            .frame(width: width)
                    }
                
                ZStack {
                    self.overlay
                        .foregroundStyle(self.config.overlayInActiveTint)
                    
                    self.overlay
                        .foregroundStyle(self.config.overlayActiveTint)
                        .mask(alignment: .leading) {
                            Rectangle()
                                .frame(width: width)
                        }
                }
                .compositingGroup()
                .animation(.easeInOut(duration: 0.3).delay(self.isActive ? 0.12 : 0)) {
                    $0.opacity(self.isActive ? 1 : 0)
                }
            }
            .modifier(content: { content in
                if self.config.isGestureActive {
                    content
                        .highPriorityGesture(
                            DragGesture(minimumDistance: 0)
                                .updating(self.$isActive) { _, out, _ in
                                    out = true
                                }
                                .onChanged { value in
                                    let progress = (value.translation.width / size.width) * self.range.upperBound + self.lastStoredValue
                                    self.value = max(min(progress, self.range.upperBound), self.range.lowerBound)
                                }
                                .onEnded { _ in
                                    self.lastStoredValue = self.value
                                }
                        )
                } else {
                    content
                }
            })
        }
        .frame(height: self.config.height + self.config.extraHeight)
        .mask {
            RoundedRectangle(cornerRadius: self.config.cornerRadius)
                .frame(height: self.config.height + (self.isActive ? self.config.extraHeight : 0))
        }
        .animation(.snappy, value: self.isActive)
    }
}
