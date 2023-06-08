//
//  HeaderView.swift
//  swift-to-do
//
//  Created by SUNGIL-POS on 2023/06/08.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        Text("오늘은 무엇을 할까요?")
            .font(.title.bold())
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
