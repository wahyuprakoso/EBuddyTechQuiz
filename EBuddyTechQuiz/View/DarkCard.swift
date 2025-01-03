//
//  DarkCard.swift
//  EBuddyTechQuiz
//
//  Created by Wahyu Prakoso on 03/01/25.
//

import SwiftUI

struct DarkCard: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .center){
                Text("Zynx")
                    .font(.system(size: 16, weight: .bold))
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.white)
                Circle()
                    .fill(Color.green)
                    .frame(width: 8, height: 8)
                Spacer()
                Image("verified")
                Image("instagram-white")
            }
            .padding()
            ZStack(alignment: .top){
                Color.red
                    .clipped()
                    .cornerRadius(16)
                Image(systemName: "star.fill")  // Replace with your image
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .clipped()
                    .padding()
                    .cornerRadius(16)
                HStack(spacing: 4){
                    Text("AVAILABLE TODAY!")
                        .font(.system(size: 8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    Image("lightning")
                }
                .padding()
            }
            .padding(.horizontal, 4)
            HStack{
                Image("round1")
                Image("round2")
                    .padding(.horizontal, -20)
                Spacer()
                Image("voice-dark")
            }
            .padding(.top, -25)
            .padding(.horizontal, 8)
            
            HStack{
                Image("star")
                    .padding(.leading, 8)
                Text("4.9")
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .bold))
                Text("(61))")
                    .foregroundStyle(.gray)
                    .font(.system(size: 14))
            }
            HStack{
                Image("mana")
                    .padding(.leading, 8)
                Text("110")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white) + Text(".00/1Hr")
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                
            }
            .padding(.bottom, 8)
        }
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
        .shadow(radius: 8)
    
    }
}

#Preview {
    DarkCard()
}
