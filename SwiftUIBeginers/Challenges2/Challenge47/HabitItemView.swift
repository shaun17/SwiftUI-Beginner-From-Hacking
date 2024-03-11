//
//  HabitItemView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/30.
//

import SwiftUI

struct IconButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .frame(width: 30, height: 30)
    }
}

struct HabitItemView: View {
   
    @Environment(\.dismiss) var dismiss

    @ObservedObject var habit: Habit
    
    @State var name = ""
    @State var think = ""
    @State var date = Date()
    @State var times = 0
     
    var body: some View {
        NavigationView {
            Form {
                Section("主题") {
                    TextField("主题", text: $name)
                }
                
                Section("描述") {
                    TextField("描述", text: $think)
                }
                
                Section("记录时间") {
                    DatePicker("date", selection: $date)
                }
                
                Section("持续时间") {
                    VStack(alignment: .leading, spacing: 2) {
                       
                            HStack {
                                Button(action: {
                                    times -= 1
                                }, label: {
                                    Image(systemName: "minus")
                                        .font(.title)
                                })
                                .buttonStyle(IconButtonStyle())

                                TextField("\(times)", value: $times, formatter: NumberFormatter())
                                    .frame(width: 50)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                
                                Button(action: {
                                    times += 1
                                    
                                }, label: {
                                    Image(systemName: "plus")
                                        .font(.title3)
                                })
                                .buttonStyle(IconButtonStyle())
                                
                                Text("mins")
                            }

                    }
                }
            }
            .navigationTitle("记录")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button("SAVE") {
                    saveword()
                }
            })
            
        }
       
    }
    
    
    func saveword(){
        let item = HabitItem(name: name , date: date, think: think, time: times)
        habit.habitItems.append(item)
        print(habit.habitItems)
        dismiss()
    }
        
}

struct HabitItemView_Previews: PreviewProvider {
    static var previews: some View {
        let habitItem = HabitItem(name: "跑步", date: Date(), think: "这是本人的第一次记录", time: 15)
        let habit = Habit("run",[habitItem])
        
        HabitItemView(habit: habit)
    }
}

// #Preview {
//    let habit = HabitItem(name: "name", date: Date(), think: "thinl", time: 15)
//    HabitItemView(habitItem: habit)
// }
