//
//  ContentView.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreData

/// The main view displaying a list of matches fetched from an API.
struct ContentView: View {
    @StateObject private var viewModel: MatchViewModel
    
    /// Initializes the view with API and Storage services.
    /// - Parameters:
    ///   - apiService: Service conforming to `APIServiceProtocol`.
    ///   - storageService: Service conforming to `StorageServiceProtocol`.
    init(apiService: APIServiceProtocol,
         storageService: StorageServiceProtocol) {
        _viewModel = StateObject(wrappedValue: MatchViewModel(apiService: apiService, storageService: storageService))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 32) {
                    /// Displays a loading indicator while matches are being fetched.
                    if viewModel.matches.isEmpty {
                        ProgressView("Loading matches...")
                            .onAppear {
                                viewModel.fetchMatches()
                            }
                    } else {
                        /// Displays a list of match cards when data is available.
                        ForEach(viewModel.matches) { match in
                            MatchCardView(match: match, viewModel: viewModel)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .shadow(radius: 5)
                                )
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Matches")
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}
