//
//  SwiftUIViewTest.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/28.
//

import SwiftData
import SwiftUI

// @Model
class ClazzDemo: Codable {
    var property: String

    // 自定义的构造器
    init(property: String) {
        self.property = property
    }

    // Codable协议要求的解码方法 
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // 根据自定义逻辑解码property属性
        property = try container.decode(String.self, forKey: .property)
    }

    // Codable协议要求的编码方法
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        // 根据自定义逻辑编码property属性
        try container.encode(property, forKey: .property)
    }

    // CodingKeys枚举用于映射属性到JSON的键
    enum CodingKeys: String, CodingKey {
        case property
    }
}

struct SwiftUIViewTest: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SwiftUIViewTest()
}
