//
//  ContentView.swift
//  EBuddyTechQuiz
//
//  Created by Wahyu Prakoso on 30/12/24.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    let APP_ENV: String = {
            Bundle.main.object(forInfoDictionaryKey: "APP_ENV") as? String ?? "unknown"
        }()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(APP_ENV)
        }
        .padding()
        .task {
            getData()
        }
    }
    
    func getData() {
        let db = Firestore.firestore()
        db.collection("USERS").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
