//
//  CardView.swift
//  EBuddyTechQuiz
//
//  Created by Wahyu Prakoso on 03/01/25.
//

import SwiftUI

struct CardView: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4"]
    
    var body: some View {
        List {
            ForEach(0..<items.count / 2, id: \.self) { index in
                HStack(spacing: 16) {
                    LightCard()
                    DarkCard()
                }
                .padding(4)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    CardView()
}
