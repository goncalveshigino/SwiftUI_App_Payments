//
//  UserService.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 22/09/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserService {
    
    @Published var currentUser: User?
   
    
    static var shared = UserService()
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        FirestoreConstants.UserCollection.document(uid).getDocument { snapshot,_ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
    
   
    static func filterUserDebit() async throws -> [User]{
        let snapshot = try await FirestoreConstants.UserCollection.whereField(User.CodingKeys.debit.rawValue, isEqualTo: true).getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
    
    
}

extension Query {
    
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T : Decodable {
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
    }
}

