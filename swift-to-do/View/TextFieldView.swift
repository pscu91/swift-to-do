//
//  TextFieldView.swift
//  swift-to-do
//
//  Created by SUNGIL-POS on 2023/06/08.
//

import SwiftUI

struct TextFieldView: View {
    
    @State private var todoString = ""
    @EnvironmentObject var todoLists : TodoLists
    
    var body: some View {
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
    }
    
    func appendTodoList() {
        let inputList = TodoList(content: todoString, checked: false)

        todoLists.list.append(inputList)
        todoString = ""
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView()
    }
}
