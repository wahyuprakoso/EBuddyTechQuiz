//
//  ListUserViewModel.swift
//  EBuddyTechQuiz
//
//  Created by Wahyu Prakoso on 02/01/25.
//

import SwiftUI
import FirebaseFirestore

class ListUserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func loadUsers() {
        isLoading = true
        let db = Firestore.firestore()
        db.collection("USERS").getDocuments { snapshot, error in
            self.isLoading = false
            if let error = error {
                self.errorMessage = "Error fetching documents: \(error.localizedDescription)"
            } else {
                self.users = snapshot?.documents.compactMap { document in
                    try? document.data(as: User.self)
                } ?? []
            }
        }
    }
}
