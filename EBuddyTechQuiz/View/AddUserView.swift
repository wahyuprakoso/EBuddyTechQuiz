//
//  AddUserView.swift
//  EBuddyTechQuiz
//
//  Created by Wahyu Prakoso on 03/01/25.
//

import SwiftUI

struct AddUserView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var profileImage: UIImage? = nil
    @State private var showCameraPicker = false
    @State private var showGalleryPicker = false
    @State private var showActionSheet = false
    @State private var email: String = ""
    @State private var gender: String = "Female"
    @State private var phoneNumber: String = ""
    @State var user: User?
    
    var body: some View {
        NavigationView {
            VStack {
                if let uiImage = profileImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        .onTapGesture {
                            showActionSheet = true
                        }
                }else if let imagUrl = user?.image {
                    AsyncImage(url: URL(string: imagUrl)) { phase in
                        switch phase {
                        case .failure:
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                                .onTapGesture {
                                    showActionSheet = true
                                }
                        case .success(let image):
                            image
                                .frame(width: 256, height: 256)
                                .clipShape(.rect(cornerRadius: 25))
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                                .onTapGesture {
                                    showActionSheet = true
                                }
                        default:
                            ProgressView()
                        }
                    }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        .onTapGesture {
                            showActionSheet = true
                        }
                }
                Form {
                    Section {
                        TextField("Enter your email", text: $email)
                            .keyboardType(.emailAddress)
                        TextField("Enter your phone number", text: $phoneNumber)
                            .keyboardType(.numberPad)
                    }
                    Section {
                        Picker("Gender", selection: $gender) {
                            ForEach(["Female", "Male"], id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Section{
                        Text(user?.uid ?? "-")
                            .font(.body)
                    }
                }
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Change Profile Photo"),
                    message: Text("Choose a source"),
                    buttons: [
                        .default(Text("Camera")) {
                            showCameraPicker = true
                        },
                        .default(Text("Gallery")) {
                            showGalleryPicker = true
                        },
                        .cancel()
                    ]
                )
            }
            .sheet(isPresented: $showCameraPicker) {
                ImagePicker(image: $profileImage, sourceType: .camera)
            }
            .sheet(isPresented: $showGalleryPicker) {
                ImagePicker(image: $profileImage, sourceType: .photoLibrary)
            }
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if let user = user {
                            if let profileImage = profileImage {
                                UserViewModel.shared.uploadImage(profileImage, to: "image/\(user.uid!).jpg") { result in
                                    switch result {
                                    case .success(let imageURL):
                                        UserViewModel.shared.updateUser(User(uid: user.uid, email: email, phoneNumber: phoneNumber, gender: gender == "Female" ? .female : .male))
                                        UserViewModel.shared.saveImageURL(imageURL, forUserID: user.uid!) { result in
                                            switch result {
                                            case .success:
                                                dismiss()
                                            case .failure(let error):
                                                print(error)
                                            }
                                        }
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                            }else{
                                UserViewModel.shared.updateUser(User(uid: user.uid, email: email, phoneNumber: phoneNumber, gender: gender == "Female" ? .female : .male))
                                dismiss()
                            }
                        }else{
                            UserViewModel.shared.addUser(email: email, phoneNumber: phoneNumber, gender: gender == "Female" ? 0 : 1) { result in
                                switch result {
                                case .success:
                                    dismiss()
                                case .failure(let error):
                                    print(error)
                                }
                            }
                        }
                    }) {
                        Text("Save")
                    }
                }
            }
            .onAppear {
                if let user = user {
                    print("user = \(user)")
                    email = user.email ?? ""
                    phoneNumber = user.phoneNumber ?? ""
                    if let gen = user.gender {
                        gender = gen == .female ? "Female" : "Male"
                    }
                }
            }
        }
    }
}

#Preview {
    AddUserView(user: User())
}
