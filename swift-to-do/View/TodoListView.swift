//
//  TodoListView.swift
//  swift-to-do
//
//  Created by SUNGIL-POS on 2023/06/08.
//

import SwiftUI

struct TodoListView: View {
    
    @EnvironmentObject var todoLists : TodoLists

    var body: some View {
        List {
            ForEach(0..<todoLists.list.count, id: \.self) { i in
                HStack {
                    Button(
                        action: {
                            toggleCheckedState(i)
                        },
                        label: {
                            Image(systemName:
                                    todoLists.list[i].checked == true ? "checkmark.square.fill" : "square")
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(.blue)
                        }
                    )
                    Text(todoLists.list[i].content)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    Button(
                        action: {
                            deleteList(i)
                        },
                        label: {
                            Image(systemName: "trash")
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(.red)
                        }
                    )
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
            .listStyle(PlainListStyle())
    }
    
    func toggleCheckedState(_ i: Int) {
        todoLists.list[i].checked.toggle()
    }
    
    func deleteList(_ i: Int) {
        todoLists.list.remove(at: i)
    }
}
