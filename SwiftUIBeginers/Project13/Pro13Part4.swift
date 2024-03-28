//
//  Pro13Part4.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/28.
//

import SwiftUI
import StoreKit


struct Pro13Part4: View {
    @Environment(\.requestReview) var requestReview
    var body: some View {
        Button("leave a review") {
            requestReview()
        }
    }
}

#Preview {
    Pro13Part4()
}   
