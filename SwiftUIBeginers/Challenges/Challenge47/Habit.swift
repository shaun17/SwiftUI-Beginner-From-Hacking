//
//  Habit.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/30.
//

import Foundation


class Habit: ObservableObject, Identifiable {
    
    @Published var topic: String
    @Published var habitItems: [HabitItem]
    
    init(_ topic: String, _ habitItems: [HabitItem]){
        self.topic = topic
        self.habitItems = habitItems
    }
    
//    @Published var habitItems = [HabitItem](){
//        didSet {
//            if let encode = try? JSONEncoder().encode(habitItems){
//                UserDefaults.standard.set(encode, forKey: "HabitItems")
//            }
//        }
//    }
//    
//    init(){
//        if let items = UserDefaults.standard.data(forKey: "HabitItems"){
//            if let decode = try? JSONDecoder().decode([HabitItem].self, from: items){
//                habitItems = decode
//                return
//            }
//        }
//        habitItems = []
//    }
    
    
}

