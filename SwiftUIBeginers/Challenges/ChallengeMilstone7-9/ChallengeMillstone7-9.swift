//
//  ChallengeMillstone7-9.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/20.
//

import SwiftUI

struct ChallengeMillstone7_9: View {
    private var dataManager = DataManager()
    @State private var showingAddTopic = false // 控制新增主题的sheet显示

    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 150))
    ]

    var body: some View {
        NavigationView {
            VStack {
                // 使用LazyVGrid创建两列的正方形表格
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(dataManager.topics) { topic in
                            NavigationLink(destination: TopicDetailView(topic: topic, dataManager: dataManager)) {
                                VStack {
                                    Text(topic.name)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    Text(topic.description)
                                        .foregroundColor(.white)
                                        .font(.caption)
                                }
                                .frame(width: 150, height: 150)
                                .background(Color.random) // 使用随机颜色
                                .cornerRadius(10)
                            }
                        }
                        
                    }
                    .padding()
                }
            }
            .navigationTitle("记录成长")
            .toolbar {
                // 右上角的新增按钮
                Button(action: {
                    showingAddTopic = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddTopic) {
                // 新增主题的sheet页面
                AddTopicView(dataManager: dataManager)
            }
        }
    }
}

// 生成随机颜色的扩展
extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

#Preview {
    ChallengeMillstone7_9()
}
