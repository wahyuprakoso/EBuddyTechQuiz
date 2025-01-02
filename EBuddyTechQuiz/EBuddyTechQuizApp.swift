//
//  EBuddyTechQuizApp.swift
//  EBuddyTechQuiz
//
//  Created by Wahyu Prakoso on 30/12/24.
//

import SwiftUI

@main
struct EBuddyTechQuizApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ListUserView()
        }
    }
}
