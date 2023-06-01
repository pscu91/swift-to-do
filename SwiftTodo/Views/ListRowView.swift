//
//  Created by SUNGIL-POS on 2023/06/01.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .symbolRenderingMode(.monochrome)
                .foregroundStyle(.black)
            Text(item.title)
                .lineLimit(1)
                .truncationMode(.tail)
            Spacer()
        }
            .font(.headline)
            .padding(.vertical, 4)
            .buttonStyle(BorderlessButtonStyle())
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "hello 11", isCompleted: false)
    static var item2 = ItemModel(title: "hello 2", isCompleted: true)
    
    static var previews: some View {
        Group {s
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
    }
}
