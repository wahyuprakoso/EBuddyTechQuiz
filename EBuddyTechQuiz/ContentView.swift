//
//  ContentView.swift
//  EBuddyTechQuiz
//
//  Created by Wahyu Prakoso on 30/12/24.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    let items: [MenuItem] = [
        MenuItem(id: UUID(), name: "List User"),
        MenuItem(id: UUID(), name: "Card")
    ]
    var body: some View {
        NavigationView{
            List(items) { item in
                NavigationLink(destination: destinationView(item:item)) {
                    Text(item.name)
                        .font(.body)
                }
            }
        }
    }
    
    @ViewBuilder
    func destinationView(item: MenuItem) -> some View {
        switch item.name {
        case "List User":
            ListUserView()
        case "Card":
            CardView()
        default:
            Text("Coming Soon")
        }
    }
}

struct MenuItem: Identifiable {
    let id: UUID
    let name: String
}

#Preview {
    ContentView()
}
