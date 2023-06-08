//
//  TextFieldView.swift
//  swift-to-do
//
//  Created by SUNGIL-POS on 2023/06/08.
//

import SwiftUI

struct TextFieldView: View {

    @State private var todoString = ""
    @EnvironmentObject var todoLists: TodoLists
    @FocusState private var isFocused: Bool

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
                .disableAutocorrection(true)
                .focused($isFocused)
        }
            .textFieldStyle(DefaultTextFieldStyle())
            .frame(width: 300, height: 50, alignment: .center)
    }

    func appendTodoList() {
        let inputList = TodoList(content: todoString, checked: false)

        todoLists.list.append(inputList)
        todoString = ""
        isFocused = true
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView()
    }
}
