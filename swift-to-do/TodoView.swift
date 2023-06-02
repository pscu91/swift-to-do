//
//  TodoView.swift
//  swift-to-do
//
//  Created by SUNGIL-POS on 2023/05/31.
//

import SwiftUI

struct TodoView: View {
    
    struct TodoList: Identifiable {
        let id = UUID()
        var content: String
        var checked: Bool
    }
    
    @State private var todoString = ""
    @State private var todoLists = [TodoList]()
    
    var body: some View {
        VStack {
            Text("오늘은 무엇을 할까요?")
                .font(.title.bold())
            HStack {
                Image(systemName: "square.and.pencil")
                    .symbolRenderingMode(.monochrome)
                    .foregroundStyle(.blue)
                TextField("여기에 할 일을 입력...",
                          text: $todoString)
                .onSubmit {
                    appendTodoList()
                }
            }
            .textFieldStyle(DefaultTextFieldStyle())
            .frame(width: 300, height: 50, alignment: .center)
            List {
                ForEach(0..<todoLists.count, id: \.self) { i in
                    HStack {
                        Button(
                            action: {
                                toggleCheckedState(i)
                            },
                            label: {
                                Image(systemName:
                                        todoLists[i].checked == true ? "checkmark.square.fill" : "square")
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(todoLists[i].checked == true ? .blue : .black)
                            }
                        )
                        Text(todoLists[i].content)
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
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding(.top)
    }
    
    func appendTodoList() {
        let inputList = TodoList(content: todoString, checked: false)
        todoLists.append(inputList)
        todoString = ""
    }
    
    func toggleCheckedState(_ i: Int) {
        todoLists[i].checked.toggle()
    }
    
    func deleteList(_ i: Int) {
        todoLists.remove(at: i)
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
