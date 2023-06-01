//
//  Created by SUNGIL-POS on 2023/05/31.
//

import SwiftUI

struct ListView: View {

    @State var items: [ItemModel] = [
        ItemModel(title: "hi", isCompleted: false),
        ItemModel(title: "hello", isCompleted: true),
        ItemModel(title: "bye", isCompleted: false),
    ]

    var body: some View {
        List {
            ForEach(items) { item in
                ListRowView(item: item)
            }
                .onDelete(perform: deleteItem)
                .onMove(perform: moveItem)
        }
            .listStyle(.plain)
            .navigationTitle("오늘, 무엇을 할까요?")
            .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AddView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }

    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
    }
}
