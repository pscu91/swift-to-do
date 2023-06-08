//
//  Objects.swift
//  swift-to-do
//
//  Created by SUNGIL-POS on 2023/06/08.
//

import Foundation

struct TodoList: Identifiable, Codable {
    var id = UUID()
    var content: String
    var checked: Bool
}

class TodoLists: ObservableObject {
    @Published var list = [TodoList]()
}
