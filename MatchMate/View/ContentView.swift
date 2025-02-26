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
    /// The view model responsible for handling match data and Core Data operations.
    @StateObject private var viewModel: MatchViewModel

    /// Initializes the view with a Core Data context.
    /// - Parameter context: The `NSManagedObjectContext` used for Core Data storage.
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: MatchViewModel(context: context))
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

#Preview {
    /// Provides a preview of `ContentView` using a sample Core Data context.
    ContentView(context: PersistenceController.preview.container.viewContext)
}
