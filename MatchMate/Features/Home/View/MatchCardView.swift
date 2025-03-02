//
//  MatchCardView.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//


import SwiftUI
import SDWebImageSwiftUI

/// A view that displays an individual match card with a profile image, details, and action buttons.
struct MatchCardView: View {
    /// The match data to display.
    let match: Match
    
    /// The view model responsible for handling match interactions.
    @ObservedObject var viewModel: MatchViewModel

    var body: some View {
        VStack {
            // Profile Image with Gradient Overlay
            ZStack(alignment: .bottom) {
                WebImage(url: URL(string: match.imageUrl ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 350)
                    .clipped()
                    .overlay(
                        /// Adds a black gradient overlay at the bottom for better text visibility.
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .black.opacity(0.6)]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                // Content Overlay (Name, Age, Location)
                VStack(alignment: .center) {
                    Spacer()
                    
                    /// Displays the match's name and age.
                    Text("\(match.name ?? ""), \(match.age)")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)

                    /// Displays the match's location.
                    Text("\(match.location ?? "")")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 16)
                        .padding(.leading, 16)
                }
                .frame(width: 300, height: 350)
            }
            .padding(.leading, 16)
            .padding(.top, 16)
            .padding(.bottom, 8)
            .padding(.trailing, 16)
            
            /// Displays the Accept & Reject buttons.
            StatusView(match: match, viewModel: viewModel)
                .padding(.bottom, 16)
        }
        .background(
            /// Adds a rounded white background with a shadow effect.
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
        )
    }
}
