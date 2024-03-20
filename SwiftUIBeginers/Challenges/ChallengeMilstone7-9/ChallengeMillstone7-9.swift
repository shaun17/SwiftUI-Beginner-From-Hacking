

import SwiftUI

struct ChallengeMillstone7_9: View {
    var dataManager: DataManager
    @State private var showingAddTopic = false // 控制新增主题的sheet显示
    @State private var removeTopic = false // 控制新增主题的sheet显示
    let colums = [
        GridItem(.adaptive(minimum: 150, maximum: 150))
    ]
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: colums, spacing: 20, content: {
                        ForEach(dataManager.topics) { topic in
                            ZStack(alignment: .topTrailing) { // 使用ZStack来叠加视图
                                
                                NavigationLink {
                                    TopicDetailView(dataManager: dataManager, topic: topic)
                                } label: {
                                    VStack {
                                        Text(topic.name)
                                            .font(.title.bold())
                                            .foregroundColor(.white)
                                        Text(topic.description)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 150, height: 150)
                                    .background(Color.random)
                                    .cornerRadius(10)
                                    
                                }
                                
                                if removeTopic {
                                    Button(action: {
                                        if let index = dataManager.topics.firstIndex(where: { $0.id == topic.id }){
                                            dataManager.removeTopic(at:  IndexSet(integer: index))
                                        }
                                        
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }

                        
                        
                    })
                    .padding()
                    
                }
            }
            .navigationTitle("记录成长")
            .toolbar(content: {
                // 右上角的新增按钮
                               Button(action: {
                                   showingAddTopic = true
                               }) {
                                   Image(systemName: "plus")
                               }
            })
            .sheet(isPresented: $showingAddTopic, content: {
                AddTopicView(dataManager: dataManager)
            })
            .toolbar {
                if removeTopic {
                    Button("保存", systemImage: "cancel") {
                        removeTopic.toggle()
                    }
                    
                }else {
                    Button("编辑", systemImage: "pencil") {
                        removeTopic.toggle()
                    }
                    
                }
                       }
        }
    }
}

extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}

#Preview {
    ChallengeMillstone7_9(dataManager: DataManager())
}
