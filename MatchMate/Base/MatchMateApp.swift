//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 25/02/25.
//

import SwiftUI

@main
struct MatchMateApp: App {
    
    let persistenceController = PersistenceController.shared
    let apiService = APIService.shared
    let storageService: StorageServiceProtocol
    
    init() {
        self.storageService = CoreDataStorageService(context: persistenceController.container.viewContext)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(apiService: self.apiService,
                        storageService: self.storageService)
        }
    }
}
