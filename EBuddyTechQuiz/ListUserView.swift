//
//  ListUserView.swift
//  EBuddyTechQuiz
//
//  Created by Wahyu Prakoso on 02/01/25.
//

import SwiftUI

struct ListUserView: View {
    @StateObject private var viewModel = ListUserViewModel()
    
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
                    }
                }
            }
            .navigationTitle("Users")
            .task {
                viewModel.loadUsers()
            }
        }
    }
}

#Preview {
    ListUserView()
}
