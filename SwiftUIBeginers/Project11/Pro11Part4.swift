//
//  Pro11Part4.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/25.
//

import SwiftUI

struct Pro11Part4: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RatingViewPro11: View {
    @Binding var rating: Int
    var label = ""
    var maxRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            ForEach(1 ..< maxRating + 1, id: \.self) { rate in
                Button {
                    rating = rate
                } label: {
                    image(for: rate).foregroundColor(rate > rating ? offColor : onColor)
                }
            }
        }
        .buttonStyle(.plain)
    }

    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

struct EmojiRatingViewPro11: View {
    let rating: Int
    var body: some View {
        switch rating {
            case 1:
                Text("1⭐️")
            case 2:
                Text("2⭐️")
            case 3:
                Text("3⭐️")
            case 4:
                Text("4⭐️")
            default:
                Text("5⭐️")
        }
    }
}

#Preview {
    RatingViewPro11(rating: .constant(4))
}
