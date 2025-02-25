//
//  StatusView.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import SwiftUI

struct StatusView: View {
    let match: Match
    @ObservedObject var viewModel: MatchViewModel
    
    var body: some View {
        HStack(spacing: 50) {
            if match.status == MatchStatus.none {
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
                            .overlay(Circle().stroke(Color.red.opacity(0.6), lineWidth: 2))
                            .foregroundColor(.red.opacity(0.6))
                    }
                }
                
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
                            .overlay(Circle().stroke(Color.green.opacity(0.6), lineWidth: 2))
                            .foregroundColor(.green.opacity(0.6))

                    }
                }
            } else {
                VStack {
                    Image(systemName: match.status == .accepted ? "checkmark" : "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .padding(12)
                        .background(match.status == .accepted ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                        .clipShape(Circle())
                        .foregroundColor(match.status == .declined ? .red.opacity(0.8) : .green.opacity(0.8))
                    
                    Text(match.status == .accepted ? "Accepted" : "Declined")
                        .font(.caption)
                        .foregroundColor(match.status == .accepted ? .green.opacity(0.8) : .red.opacity(0.8))
                }
            }
        }
    }
}
