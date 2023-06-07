//
//  TodoView.swift
//  swift-to-do
//
//  Created by SUNGIL-POS on 2023/05/31.
//

import SwiftUI

struct TodoView: View {

    struct TodoList: Identifiable, Codable {
        var id = UUID()
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
            HStack(spacing: 50) {
                Button(
                    action: { saveTodoList() },
                    label: {
                        HStack {
                            Image(systemName: "folder")
                            Text("임시저장")
                        }
                    }
                )
                    .padding(.all, 10)
                Button(
                    action: { loadTodoList() },
                    label: {
                        HStack {
                            Image(systemName: "tray.and.arrow.up")
                            Text("불러오기")
                        }
                    }
                )
                    .padding(.all, 10)
            }
                .buttonStyle(BorderlessButtonStyle())
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

    func getDocumentPath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    func dataToJsonString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let data = try encoder.encode(todoLists)
            return String(data: data, encoding: .utf8)
        }
        catch {
            print(error.localizedDescription)
        }

        return nil
    }

    func saveTodoList() {
        let path = getDocumentPath().appendingPathComponent("todolist.json")
        let jsonString = dataToJsonString()

        if jsonString == nil {
            print("Error: No JSON String found")
            return
        }

        do {
            try jsonString?.write(to: path, atomically: true, encoding: .utf8)
        }
        catch {
            print(error.localizedDescription)
        }
    }

    func jsonStringToData(_ jsonString: String) -> [TodoList]? {

        let decoder = JSONDecoder()
        let jsonData = jsonString.data(using: .utf8)

        if jsonData == nil {
            print("Error: Cannot convert json string to data")
            return nil
        }

        do {
            let returnList = try decoder.decode([TodoList].self, from: jsonData!)
            return returnList
        }

        catch {
            print(error.localizedDescription)
        }

        return nil
    }

    func loadTodoList() {
        let path = getDocumentPath().appendingPathComponent("todolist.json")

        do {
            let jsonString = try String(contentsOf: path)
            let jsonData = jsonStringToData(jsonString)

            if jsonData == nil {
                print("Error: no array found")
                return
            }

            todoLists = jsonData!
        }

        catch {
            print(error.localizedDescription)
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
