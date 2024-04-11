//
//  Pro8Part4.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/11.
//

import SwiftUI

struct Pro18Part4: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
//    let colors: [Color] = [Color(hue: 1.0, saturation: 1.0, brightness: 1.0)]

    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0 ..< 50) { index in
                    GeometryReader { proxy in
                        Text("Row \(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(self.colorForView(proxy: proxy, in: fullView))
                            .rotation3DEffect(
                                .degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5,
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                            .opacity(self.opacityForView(proxy: proxy))
                            .scaleEffect(self.scaleForView(proxy: proxy, in: fullView))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
    func colorForView(proxy: GeometryProxy, in fullView: GeometryProxy) -> Color {
            let minY = proxy.frame(in: .global).minY
            let height = fullView.size.height
            let position = minY / height // 计算视图的垂直位置比例

            // 使用色调值创建颜色，色调值随视图的垂直位置变化
            return Color(hue: position, saturation: 1, brightness: 1)
        }
    // 根据视图在全局坐标系中的垂直位置计算缩放比例
    func scaleForView(proxy: GeometryProxy, in fullView: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .global).minY
        let height = fullView.size.height
        let position = minY / height // 计算视图的垂直位置比例

        // 根据视图的垂直位置调整比例，靠近底部的视图大，靠近顶部的视图小
        let minScale: CGFloat = 0.5 // 最小缩放比例
        let maxScale: CGFloat = 1.0 // 最大缩放比例
        let scaleRange = maxScale - minScale
        let scale = minScale + scaleRange * position // 计算缩放比例

        return max(scale, minScale) // 确保缩放比例不小于最小缩放比例
    }

    // 根据视图的全局Y位置计算不透明度
    func opacityForView(proxy: GeometryProxy) -> Double {
        let minY = proxy.frame(in: .global).minY
        let startFade = 200.0 // 从顶部200点开始淡出
        let fadeDistance = 100.0 // 淡出距离

        // 如果视图的minY小于startFade，计算不透明度
        if minY < startFade {
            return Double(1 - (startFade - minY) / fadeDistance)
        } else {
            return 1.0
        }
    }
}

struct Pro18Part4View2: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0, content: {
                ForEach(0 ..< 20) { num in
                    Text("Number\(num)")
                        .font(.largeTitle)
                        .padding()
                        .background(.red)
                        .frame(width: 200, height: 200)
                        .visualEffect { content, geometry in
                            content.rotation3DEffect(
                                .degrees(-geometry.frame(in: .global).minX / 10),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                        }
                }

            })
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    Pro18Part4()
}
