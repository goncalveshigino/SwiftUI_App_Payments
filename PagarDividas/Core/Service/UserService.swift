//
//  UserService.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 27/09/23.
//

//import Foundation
//import Firebase
//import FirebaseFirestoreSwift
//
//class UserService {
//
//    @Published var currentUser: User?
//
//    static var shared = UserService()
//
//    @MainActor
//    func fetchCurrentUser() async throws {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
//        let user = try snapshot.data(as: User.self)
//        self.currentUser = user
//    }
//
//    static func fetchAllUsers() async throws -> [User] {
//        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
//        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
//
//    }
//
//}
