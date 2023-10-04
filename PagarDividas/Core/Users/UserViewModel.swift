//
//  UserViewModel.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 27/09/23.
//

import Foundation
import Firebase

@MainActor
class UserViewModel: ObservableObject {
    
    @Published var users = [User]()
    @Published var selectedFilter: FilterOption? = nil
    
    init(){ Task { try await fetchUsers() }}
    
    enum FilterOption: String, CaseIterable {
        
        case noFilter
        case devendo

    }
  
    
    func filterSelected(option: FilterOption) async throws {

        switch option {
        case .noFilter: self.users = try await fetchUsers()
          
        case .devendo: self.users = try await filterUserDebit()
      
        }
        
        self.selectedFilter = option
    }
    
    func fetchUsers() async throws -> [User]{
        guard let currentUid = Auth.auth().currentUser?.uid else { return[] }
        let users = try await UserService.fetchAllUsers()
        self.users = users.filter({ $0.id != currentUid })
        return users
    }
    
    func filterUserDebit() async throws -> [User]{
        guard let currentUid = Auth.auth().currentUser?.uid else { return[] }
        let users = try await UserService.filterUserDebit()
        self.users = users.filter({ $0.id != currentUid })
        return users
    }
}
