//
//  ContentView.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import SwiftUI
import CoreData

import SwiftUI
import SDWebImageSwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel: MatchViewModel

    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: MatchViewModel(context: context))
    }

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 32) {
                    if viewModel.matches.isEmpty {
                        ProgressView("Loading matches...")
                            .onAppear {
                                viewModel.fetchMatches()
                            }
                    } else {
                        ForEach(viewModel.matches) { match in
                            MatchCardView(match: match, viewModel: viewModel)
                                .padding(.horizontal)
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
    ContentView(context: PersistenceController.preview.container.viewContext)
}

