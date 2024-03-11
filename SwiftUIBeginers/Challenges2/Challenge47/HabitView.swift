//
//  HabitView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/2.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var habit: Habit
    @State var showView  = false
    var body: some View {
        NavigationView(content: {
            VStack{
                List{
                    ForEach(habit.habitItems){ item in
                        VStack{
                            VStack(content: {

                                NavigationLink {
                                    HabitItemView(habit: habit, name: item.name, think: item.think, date: item.date, times: item.time)
                                        
                                } label: {
                                    HStack{
                                        Text(item.name)
                                    }
                                }

                            })
                        }
                    }
                }
                .navigationTitle(habit.topic)
               
                
            }
            .toolbar(content: {
                Button{
                    showView = true
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showView, content: {
                    HabitItemView(habit: habit)
                })
                
               
            })
        })
    }
}
struct HabitView_Previews: PreviewProvider {
    static var previews: some View{
        let habitItem = HabitItem(name: "跑步", date: Date(), think: "这是本人的第一次记录", time: 15)
        let habit = Habit("Running",[habitItem])
        HabitView(habit: habit)
    }
}
