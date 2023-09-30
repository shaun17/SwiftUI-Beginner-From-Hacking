//
//  SwiftUIViewDate.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/30.
//

import SwiftUI

struct SwiftUIViewDate: View {
    @State private var now = Date.now
    var body: some View {
        VStack{
            DatePicker("title", selection: $now, displayedComponents: .hourAndMinute)
            DatePicker("title", selection: $now, in: Date.now...)
            Text(Date.now, format: .dateTime.hour().minute().day().year().second().month())
            Text(Date.now.formatted(date: .numeric, time: .standard))
            
        }

    }
    
    func method(){
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components)
    }
}

struct SwiftUIViewDate_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewDate()
    }
}
