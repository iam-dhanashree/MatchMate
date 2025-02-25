//
//  MatchCardView.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//


import SwiftUI
import SDWebImageSwiftUI

struct MatchCardView: View {
    let match: Match
    @ObservedObject var viewModel: MatchViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            // Profile Image with Gradient Overlay
            WebImage(url: URL(string: match.imageUrl ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 350)
                .clipped()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.6)]),
                        startPoint: .center,
                        endPoint: .bottom
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))

            // Content Overlay
            VStack(alignment: .center, spacing: 4) {
                Spacer()

                // Name & Age
                Text("\(match.name ?? ""), \(match.age)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)

                // Location
                Text("\(match.location ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)

                // Accept & Reject Buttons
                StatusView(match: match, viewModel: viewModel)
                    .padding(.bottom, 8)
            }
            .frame(width: 300, height: 350)
        }
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 5))
        .padding()
    }
}
