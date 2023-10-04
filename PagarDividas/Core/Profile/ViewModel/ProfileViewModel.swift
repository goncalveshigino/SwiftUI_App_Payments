//
//  ProfileViewModel.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 27/09/23.
//

import PhotosUI
import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var users = [User]()
    
    @Published var selectedItem: PhotosPickerItem? {didSet { Task { try await loadImage() }} }
    @Published var profileImage: Image?
    
    init(){ Task { try await fetchUsers() }}
    
    @MainActor
    func loadImage() async throws {
        guard let item = selectedItem else { return }
        guard let imageData = try await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: uiImage)
    }
    
    @MainActor
    func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        self.users = users.filter({ $0.id != currentUid })
    }
}
