//
//  ContentView.swift
//  EBuddyTechQuiz
//
//  Created by Wahyu Prakoso on 30/12/24.
//

import SwiftUI

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
    }
}

#Preview {
    ContentView()
}
