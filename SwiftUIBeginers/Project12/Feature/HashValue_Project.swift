//
//  HashValue_Project.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/14.
//

import SwiftUI

struct People: Hashable{
    var name: String
}
struct HashValue_Project: View {
    var students = [People(name: "Tom Jecsion"), People(name: "Yilian Deton")]
    
    var body: some View {
        List{
            ForEach(students, id: \.self){ student in
                Text(student.name)
            }
        }
    }
}

#Preview {
    HashValue_Project()
}
