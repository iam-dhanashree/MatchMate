//
//  StatusView.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import SwiftUI

/// A view that displays the status of a match and allows the user to accept or decline it.
struct StatusView: View {
    /// The match whose status is being displayed or updated.
    let match: Match
    
    /// The view model responsible for handling match interactions.
    @ObservedObject var viewModel: MatchViewModel
    
    var body: some View {
        HStack(spacing: 50) {
            if match.status == MatchStatus.none {
                // Decline Button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.updateMatchStatus(match: match, status: "declined")
                    }
                }) {
                    VStack {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .padding(12)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.red.opacity(0.6), lineWidth: 2)) // Red border
                            .foregroundColor(.red.opacity(0.6)) // Red icon
                    }
                }
                
                // Accept Button
                Button(action: {
                    withAnimation(.spring()) {
                        viewModel.updateMatchStatus(match: match, status: "accepted")
                    }
                }) {
                    VStack {
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .padding(12)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.green.opacity(0.6), lineWidth: 2)) // Green border
                            .foregroundColor(.green.opacity(0.6)) // Green icon
                    }
                }
            } else {
                // Display status after selection
                VStack {
                    Image(systemName: match.status == .accepted ? "checkmark" : "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .padding(12)
                        .background(match.status == .accepted ? Color.green.opacity(0.2) : Color.red.opacity(0.2)) // Background color
                        .clipShape(Circle())
                        .foregroundColor(match.status == .declined ? .red.opacity(0.8) : .green.opacity(0.8)) // Icon color
                    
                    /// Displays the status text below the icon.
                    Text(match.status == .accepted ? "Accepted" : "Declined")
                        .font(.caption)
                        .foregroundColor(match.status == .accepted ? .green.opacity(0.8) : .red.opacity(0.8))
                }
            }
        }
    }
}
