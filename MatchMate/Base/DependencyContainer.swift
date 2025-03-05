//
//  DependencyContainer.swift
//  MatchMate
//
//  Created by Dhanashree Nandurkar on 05/03/25.
//

import Foundation

protocol DependencyContainerProtocol {
    var apiManager: APIServiceProtocol { get }
    var storageManager: CoreDataProtocol { get }
}

final class DependencyContainer: DependencyContainerProtocol {
    var apiManager: APIServiceProtocol
    var storageManager: CoreDataProtocol
    
    init(apiManager: APIServiceProtocol = APIService(),
         storageManager: CoreDataProtocol = CoreDataManager(context: PersistenceController.shared.container.viewContext)) {
        self.apiManager = apiManager
        self.storageManager = storageManager
    }
}
