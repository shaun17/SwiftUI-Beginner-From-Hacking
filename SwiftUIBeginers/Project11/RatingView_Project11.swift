//
//  RatingView_Project11.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/12.
//

import SwiftUI

struct RatingView_Project11: View {
    @Binding var rating: Int
    
    var label = ""
    var maxRating = 5
    
    var offImage : Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
       
    }
    
    var body: some View {
        HStack {
            if label.isEmpty {
                Text(label)
            }
            
            ForEach(1 ..< maxRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
}

#Preview {
    RatingView_Project11(rating: .constant(3))
}
