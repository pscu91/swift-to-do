//
//  swift_to_doApp.swift
//  swift-to-do
//
//  Created by SUNGIL-POS on 2023/05/31.
//

import SwiftUI

@main
struct swift_to_doApp: App {
    
    @StateObject private var todoLists = TodoLists()
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(todoLists)
        }
    }
}
