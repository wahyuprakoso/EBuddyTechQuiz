//
//  UserViewModel.swift
//  EBuddyTechQuiz
//
//  Created by Wahyu Prakoso on 03/01/25.
//
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var users: [User] = [User]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    static let shared = UserViewModel()
    
    private let db = Firestore.firestore()
    
    func fetchUsers() {
        isLoading = true
        db.collection("USERS").getDocuments { snapshot, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = "Error fetching users: \(error.localizedDescription)"
                    return
                }
                self.users = snapshot?.documents.compactMap { document in
                    try? document.data(as: User.self)
                } ?? []
            }
        }
    }
    
    func addUser(email: String? = nil, phoneNumber: String? = nil, gender: Int? = nil ,completion: @escaping (Result<Void, Error>) -> Void) {
        var user = [String: Any]()
        if let email = email{
            user["email"] = email
        }
        if let phoneNumber = phoneNumber{
            user["phoneNumber"] = phoneNumber
        }
        if let gender = gender{
            user["ge"] = gender
        }
        let userRef = db.collection("USERS").document()
        userRef.setData(user) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                userRef.updateData(["uid": userRef.documentID]) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        self.users.append(User(uid: userRef.documentID, email: email, phoneNumber: phoneNumber, gender: gender == 0 ? .female : .male))
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    func updateUser(_ user: User) {
        guard let id = user.uid else { return }
        do {
            try db.collection("USERS").document(id).setData(from: user)
            if let index = users.firstIndex(where: { $0.id == id }) {
                users[index] = user
            }
        } catch {
            print("Error updating user: \(error.localizedDescription)")
        }
    }
    
    func uploadImage(_ image: UIImage, to path: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NSError(domain: "Image Conversion", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }

        let storageRef = Storage.storage().reference().child(path)
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                }
            }
        }
    }

    func saveImageURL(_ url: String, forUserID userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let userRef = db.collection("USERS").document(userID)
        userRef.updateData(["image": url]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                if let index = self.users.firstIndex(where: { $0.uid == userID }) {
                    self.users[index].image = url
                }
                completion(.success(()))
            }
        }
    }
}
