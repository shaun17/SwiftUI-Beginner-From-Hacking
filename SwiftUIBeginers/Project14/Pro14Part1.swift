//
//  ProPart1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/29.
//

import SwiftUI

struct User: Identifiable, Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName > rhs.firstName
    }

    let id = UUID()
    var firstName: String
    var lastName: String
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct Pro14Part1: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()

    let value = [1, 5, 3, 6, 2, 9].sorted()
    

    
    enum LoadingState {
        case loading, success, failed
    }
    
    @State private var loadingState = LoadingState.loading

    
    var body: some View {
        
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }

        Section{
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
        
        Spacer()
        
        Button("Read and Write") {
            let data = Data("Test Message".utf8)
            let url = URL.documentsDirectory.appending(path: "message.txt")
            do {
                try data.write(to: url, options: [.atomic, .completeFileProtection])
                let input = try String(contentsOf: url)
                print(input)

            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}

#Preview {
    Pro14Part1()
}
