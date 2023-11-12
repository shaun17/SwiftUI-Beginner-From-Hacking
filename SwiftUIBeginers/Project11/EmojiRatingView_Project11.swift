//
//  EmojiRatingView_Project11.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/12.
//

import SwiftUI

struct EmojiRatingView_Project11: View {
    var rating : Int16
    var body: some View {
        switch rating {
        case 1:
            Text("😔")
        case 2:
            Text("😟")
        case 3:
            Text("😀")
        case 4:
            Text("☺️")
        default:
            Text("🤩")
        }
    }
}

#Preview {
    EmojiRatingView_Project11(rating: 3)
}
