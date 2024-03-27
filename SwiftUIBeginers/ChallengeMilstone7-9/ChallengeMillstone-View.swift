//
//  ChallengeMillstone-View.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/20.
//

import SwiftUI

struct AddTopicView: View {
    var dataManager: DataManager
    @State private var name = ""
    @State private var description = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form(content: {
                TextField("主题名称", text: $name)
                TextField("主题描述", text: $description)
                Button("保存") {
                    dataManager.addTopic(name: name, description: description)
                    dismiss()
                }

            })
            .navigationTitle("新增主题")
        }
    }
}

struct TopicDetailView: View {
    var dataManager: DataManager
    var topic: Topic
    @State private var showingAddRecord = false // 控制新增记录的sheet显示

    var body: some View {
        List {
            ForEach(topic.records) { record in
                VStack(alignment: .leading, content: {
                    Text(record.location).font(.headline)
                    Text(record.description).font(.caption)
                    Text("Date: \(record.date.formatted(date: .abbreviated, time: .shortened))")
                    Text("Duration: \(record.duration) minutes")
                    Text("Feedback: \(record.feedback)")
                })
            }
            .onDelete(perform: { indexSet in
                removeRecod(at: indexSet)
            })
        }
        .navigationTitle(topic.name)
        .toolbar {
            // 右上角的新增按钮
            Button(action: {
                showingAddRecord = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showingAddRecord, content: {
            AddRecordView(topicID: topic.id, dataManager: dataManager)

        })
    }
    
    func removeRecod(at offSet: IndexSet){
        dataManager.removeRecord(to: topic.id,at: offSet)
    }
}

struct AddRecordView: View {
    var topicID: UUID
    var dataManager: DataManager
    @State private var location = ""
    @State private var description = ""
    @State private var date = Date()
    @State private var duration = 0
    @State private var feedback = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form {
                TextField("记录地点", text: $location)
                TextField("记录描述", text: $description)
                DatePicker("时间", selection: $date, displayedComponents: .date)
                Stepper("持续时间（分钟）: \(duration)", value: $duration, in: 0 ... 1440, step: 5)
                TextField("状态反馈", text: $feedback)
                Button("保存") {
                    dataManager.addRecord(to: topicID, location: location, description: description, date: date, duration: duration, feedback: feedback)
                    dismiss()
                }
            }
            .navigationTitle("新增记录")
        }
    }
}


#Preview {
    AddTopicView(dataManager: DataManager())
}
