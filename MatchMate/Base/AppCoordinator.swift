//
//  AppCoordinator.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 05/03/25.
//

import SwiftUI

protocol Coordinator: AnyObject {
    /// Commanly required dependencies
    var dependencies: DependencyContainerProtocol { get }
    
    /// Workflow
    associatedtype RootView: View
    func start() -> RootView
}

class AppCoordinator: Coordinator {
    private(set) var dependencies: DependencyContainerProtocol
    
    init(dependencies: DependencyContainerProtocol) {
        self.dependencies = dependencies
    }

    func start() -> ContentView {
        let viewModel = MatchViewModel(apiService: dependencies.apiManager, storageService: dependencies.storageManager)
        return ContentView(viewModel: viewModel)
    }
}
