//
//  ContentView.swift
//  swift-to-do
//
//  Created by SUNGIL-POS on 2023/05/31.
//

import SwiftUI

struct TodoList: Identifiable {
    let id = UUID()
    var content: String
    var checked: Bool
}

struct ContentView: View {

    @State private var toDoString = ""
    @State private var todoLists = [TodoList]()

    func appendTodoList() {
        let addList = TodoList(content: toDoString, checked: false)

        todoLists.append(addList)
        toDoString = ""
    }

    func toggleCheckedState(_ i: Int) {
        todoLists[i].checked.toggle()
    }

    var body: some View {
        VStack {
            Text("오늘은 무엇을 할까?")
                .font(.title.bold())
            HStack {
                Image(systemName: "square.and.pencil")
                TextField("여기에 할 일을 입력...", text: $toDoString,
                    onCommit: {
                        appendTodoList()
                    })
            }
                .frame(width: 300, height: 50, alignment: .center)
            List {
                ForEach(0..<todoLists.count, id: \.self) { i in
                    HStack {
                        Button(action: {
                            toggleCheckedState(i)
                        }, label: {
                                Image(systemName:
                                        todoLists[i].checked == true ? "checked.square" : "square")
                            })
                        Text(todoLists[i].content)
                        Spacer()
                        Button(action: { }, label: {
                                Image(systemName: "trash")
                            })
                    }
                }
            }
                .listStyle(PlainListStyle())
        }
            .padding(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
