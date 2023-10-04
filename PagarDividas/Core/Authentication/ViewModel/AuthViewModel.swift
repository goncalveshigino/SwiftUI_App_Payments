//
//  AuthViewModel.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 21/09/23.
//

//import Foundation
//import Firebase
//import FirebaseFirestoreSwift
//
//
//protocol AuthenticationFormProtocol {
//    var formIsValid: Bool { get }
//}
//
//@MainActor
//class AuthViewModel: ObservableObject {
//    
//    @Published var userSession: FirebaseAuth.User?
//    @Published var currentUser: User?
//    @Published var users = [User]()
//    
//    init() {
//        self.userSession = Auth.auth().currentUser
//        Task {
//            await fetchUser()
//            try await fetchAllUsers()
//        }
//    }
//    
//    func signIn(withEmail email: String, password: String) async throws {
//        do {
//            let result = try await Auth.auth().signIn(withEmail: email, password: password)
//            self.userSession = result.user
//            await fetchUser()
//        } catch {
//            print("DEBUG: Failed to Log in user with error \(error.localizedDescription)")
//        }
//    }
//    
//    func createUser(withEmail email: String, password: String, fullname: String) async throws {
//        do {
//            let result = try await Auth.auth().createUser(withEmail: email, password: password)
//            self.userSession = result.user
//            let user = User(id: result.user.uid, fullname: fullname, email: email)
//            let encodedUser = try Firestore.Encoder().encode(user)
//            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
////            await uploadUserData(id: result.user.uid, fullname: fullname, email: email)
//            
//    
//            await fetchUser()
//            
//        } catch {
//            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
//        }
//    }
//    
//    func deleteAccount() {
//        
//    }
//    
//    func fetchUser() async {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
//        self.currentUser = try? snapshot.data(as: User.self)
//        
//    }
//    
//    
////    private func uploadUserData(id: String, fullname: String, email: String) async {
////        let user = User(id: id, fullname: fullname, email: email)
////        self.currentUser = user
////        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
////        try? await  Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
////    }
//    
//    func signOut() {
//        do {
//            try Auth.auth().signOut()
//            self.userSession = nil
//            self.currentUser = nil
//        } catch {
//            print("DEBUG: Failed to sign ou with error \(error.localizedDescription)")
//        }
//    }
//    
//    func fetchAllUsers() async throws {
//        self.users = try await UserService.fetchAllUsers()
//    }
//}
