//
//  Challenge47Days.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/29.
//

import SwiftUI

struct Challenge47Days: View {
    var tracking: [Habit]

    var body: some View {
        NavigationView(content: {
            VStack(content: {
                List {
                    ForEach(tracking) { habit in
                        NavigationLink {
                            HabitView(habit: habit)
                        }
                        label: {
                            Text(habit.topic)
                        }
                    }
                }
            
            })
            .navigationTitle("My Habits")
           
        })
    }
}

struct Challenge47Days_Preview: PreviewProvider {
    static var previews: some View {
        Challenge47Days(tracking: [Habit("跑步", []), Habit("游泳", [])])
    }
}
