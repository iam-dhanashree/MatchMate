//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import SwiftUI

@main
struct MatchMateApp: App {
    private let coordinator: any Coordinator

    init() {
        let container: DependencyContainerProtocol = DependencyContainer()
        self.coordinator = AppCoordinator(dependencies: container)
    }

    var body: some Scene {
        WindowGroup {
            AnyView(coordinator.start())
        }
    }
}
