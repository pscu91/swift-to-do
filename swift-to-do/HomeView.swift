//
//  HomeView.swift
//  swift-to-do
//
//  Created by SUNGIL-POS on 2023/05/31.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var todoLists : TodoLists
    
    var body: some View {
        VStack {
            HeaderView()
            TextFieldView()
            TodoListView()
            SaveLoadButtonView()
        }
            .padding(.top)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(TodoLists())
    }
}
