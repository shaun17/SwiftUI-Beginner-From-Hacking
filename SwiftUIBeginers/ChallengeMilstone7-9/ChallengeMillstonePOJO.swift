
//
//  ChallengeMillstonePOJO.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/20.
//

import SwiftUI

struct Record: Identifiable, Codable {
    var id = UUID()
    var location: String
    var description: String
    var date: Date
    var duration: Int // 持续时间，以分钟为单位
    var feedback: String // 状态反馈
}

struct Topic: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var records: [Record] = []
}

@Observable
class DataManager {
    var topics = [Topic]()
    private let key = "TopicsData"

    init() {
        loadTopic()
    }

    // 加载持久化的数据
    func loadTopic() {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let dbTopics = try? JSONDecoder().decode([Topic].self, from: data) {
                topics = dbTopics
            }
        }
    }

    // 保存主题到UserDefaults
    func saveTopic() {
        if let encoder = try? JSONEncoder().encode(topics) {
            UserDefaults.standard.setValue(encoder, forKey: key)
        }
    }


    // 删除出题
    func removeTopic(at offsets: IndexSet) {
        topics.remove(atOffsets: offsets)
        saveTopic()
    }

    // 添加新主题
    func addTopic(name: String, description: String) {
        let topic = Topic(name: name, description: description)
        topics.append(topic)
        saveTopic()
    }

    // 添加新记录到指定主题
    func addRecord(to topicID: UUID, location: String, description: String, date: Date, duration: Int, feedback: String) {
        if let index = topics.firstIndex(where: { $0.id == topicID }) {
            let newRecord = Record(location: location, description: description, date: date, duration: duration, feedback: feedback)
            topics[index].records.append(newRecord)
            saveTopic()
        }
    }
    
    func removeRecord(to topicID: UUID, at offSet: IndexSet) {
        if let index = topics.firstIndex(where: { $0.id == topicID }) {
            topics[index].records.remove(atOffsets: offSet)
            saveTopic()
        }
    }
}
