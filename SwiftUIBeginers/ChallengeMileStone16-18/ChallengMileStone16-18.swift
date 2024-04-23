//
//  ChallengMileStone16-18.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/23.
//

import SwiftUI

struct ChallengMileStone16_18: View {
    @State private var roundAcount = 1
    @State private var face = 6

    var body: some View {
        NavigationStack {
            VStack{
                Form(content: {
                    Section {
                        Stepper(value: $roundAcount, in: 1 ... 5, step: 1) {
                            Text("Round Count: \(roundAcount)")
                        }
                    }
                  
                    
                    Picker("Tip percentage", selection: $face) {
                        ForEach(4 ..< 101, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                })
                NavigationLink(destination: ChallengeSubView(sum: roundAcount, face: face)) {
                    Text("Next")
                }
            }
            .navigationTitle("Chose Setting")

        }
    }
}


#Preview {
    ChallengMileStone16_18()
}
