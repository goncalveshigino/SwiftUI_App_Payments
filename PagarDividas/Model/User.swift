//
//  User.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 21/09/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


struct User: Codable, Identifiable,Hashable {
    @DocumentID var uid: String?
    let fulName: String
    let email: String
    var saldo: Double = 0.0
    var profileImageUrl: String?
    var debit: Bool = false
    var debt: Double = 0.0
  
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
    
    var isCurrentUser: Bool {
        return uid == Auth.auth().currentUser?.uid
    }
    
    enum CodingKeys: String, CodingKey {
        case uid
        case fulName
        case email
        case saldo
        case profileImageUrl
        case debit
        case debt
    }
}

extension User {
    static let MOCK_USER = User(fulName: "Staturo Gojo", email: "saturo@gmail.com", saldo: 0, profileImageUrl: "batman")
}

//struct User: Identifiable, Hashable, Codable {
//
//    let id: String
//    let fullname: String
//    let email: String
//
//    var initials: String {
//        let formatter = PersonNameComponentsFormatter()
//        if let components = formatter.personNameComponents(from: fullname) {
//            formatter.style = .abbreviated
//            return formatter.string(from: components)
//        }
//
//        return ""
//    }
//}
//
//extension User {
//    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Staturo Gojo", email: "saturo@gmail.com")
//}
