//
//  ChallengeMillstonePOJO.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/20.
//

import SwiftUI

// 记录的数据模型
struct Record: Identifiable, Codable {
    var id = UUID()
    var location: String
    var description: String
    var date: Date
    var duration: Int // 持续时间，以分钟为单位
    var feedback: String // 状态反馈
}

// 主题的数据模型
struct Topic: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var records: [Record] = []
}

// 管理数据的类
@Observable
class DataManager {
//    @Published var topics: [Topic] = []
    var topics: [Topic] = []
    
    // UserDefaults的键
    private let topicsKey = "TopicsData"
    
    init() {
        loadTopics()
    }
    
    // 从UserDefaults加载主题
    func loadTopics() {
        if let data = UserDefaults.standard.data(forKey: topicsKey),
           let savedTopics = try? JSONDecoder().decode([Topic].self, from: data) {
            topics = savedTopics
        }
    }
    
    // 保存主题到UserDefaults
    func saveTopics() {
        if let data = try? JSONEncoder().encode(topics) {
            UserDefaults.standard.set(data, forKey: topicsKey)
        }
    }
    
    // 添加新主题
    func addTopic(name: String, description: String) {
        let newTopic = Topic(name: name, description: description)
        topics.append(newTopic)
        saveTopics()
    }
    
    // 添加新记录到指定主题
    func addRecord(to topicID: UUID, location: String, description: String, date: Date, duration: Int, feedback: String) {
        if let index = topics.firstIndex(where: { $0.id == topicID }) {
            let newRecord = Record(location: location, description: description, date: date, duration: duration, feedback: feedback)
            topics[index].records.append(newRecord)
            saveTopics()
        }
    }
}
