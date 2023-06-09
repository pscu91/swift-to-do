//
//  HomeView.swift
//  swift-to-do
//
//  Created by SUNGIL-POS on 2023/05/31.
//

import SwiftUI
import UIKit

extension UIApplication {
    func hideKeyboard() {
        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
 }
 
extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

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
            .onAppear {
                UIApplication.shared.hideKeyboard()
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(TodoLists())
    }
}
