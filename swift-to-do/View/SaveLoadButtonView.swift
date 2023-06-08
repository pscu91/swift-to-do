//
//  SaveLoadButtonView.swift
//  swift-to-do
//
//  Created by SUNGIL-POS on 2023/06/08.
//

import SwiftUI

struct SaveLoadButtonView: View {
    
    @EnvironmentObject var todoLists : TodoLists
    
    var body: some View {
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

    func loadTodoList() {
        let path = getDocumentPath().appendingPathComponent("todolist.json")

        do {
            let jsonString = try String(contentsOf: path)
            let jsonData = jsonStringToData(jsonString)

            if jsonData == nil {
                print("Error: no JSON data found")
                return
            }

            todoLists.list = jsonData!
        }

        catch {
            print(error.localizedDescription)
        }
    }
    
    func dataToJsonString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let data = try encoder.encode(todoLists.list)
            return String(data: data, encoding: .utf8)
        }
        catch {
            print(error.localizedDescription)
        }

        return nil
    }
    
    func getDocumentPath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
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
}

struct SaveLoadButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveLoadButtonView()
    }
}
