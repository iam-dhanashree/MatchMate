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
                            .padding(14)
                            .background(match.status == .declined ? Color.red : Color.white.opacity(0.2))
                            .clipShape(Circle())
                            .foregroundColor(match.status == .declined ? .white : .white)
                        
                        Text("Decline")
                            .font(.caption)
                            .foregroundColor(match.status == .declined ? .red : .white.opacity(0.8))
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
                            .padding(14)
                            .background(match.status == .accepted ? Color.green : Color.white.opacity(0.2))
                            .clipShape(Circle())
                            .foregroundColor(match.status == .accepted ? .white : .white)
                        
                        Text("Accept")
                            .font(.caption)
                            .foregroundColor(match.status == .accepted ? .green : .white.opacity(0.8))
                    }
                }
            } else {
                VStack {
                    Image(systemName: match.status == .accepted ? "checkmark" : "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .padding(14)
                        .background(match.status == .accepted ? Color.green : Color.white.opacity(0.2))
                        .clipShape(Circle())
                        .foregroundColor(match.status == .declined ? .red : .white.opacity(0.8))
                    
                    Text(match.status == .accepted ? "Accepted" : "Declined")
                        .font(.caption)
                        .foregroundColor(match.status == .accepted ? .green : .white.opacity(0.8))
                }
            }
        }
    }
}
