//
//  ListUserView.swift
//  EBuddyTechQuiz
//
//  Created by Wahyu Prakoso on 02/01/25.
//

import SwiftUI

struct ListUserView: View {
    @ObservedObject private var viewModel = UserViewModel.shared
    @State private var showModal = false
    @State private var selectedUser:User?
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    List(viewModel.users) { user in
                        HStack{
                            Text(user.uid ?? "-")
                                .font(.body)
                            Text(user.gender == .male ? "Male" : "Female")
                                .font(.body)
                            Text(user.phoneNumber ?? "-")
                                .font(.body)
                            Text(user.email ?? "-")
                                .font(.body)
                        }
                        .onTapGesture {
                            if user == selectedUser {
                                showModal = true
                            }else{
                                selectedUser = user
                            }
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        selectedUser = nil
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showModal) {
                AddUserView(user: selectedUser)
            }
            .onChange(of: selectedUser) { oldValue, newValue in
                showModal = true
            }
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    ListUserView()
}
