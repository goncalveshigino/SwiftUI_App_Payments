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
    var totalDebtAmount: Double = 0.0
    var valueToReceive: Double = 0.0
    var profileImageUrl: String?
    var debt:  Bool = false
  
    
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
        case totalDebtAmount
        case valueToReceive
        case profileImageUrl
        case debt
    }
    
    
}

extension User {
    static let MOCK_USER = User(fulName: "Goncalves Higino", email: "higino@gmail.com", saldo: 0, totalDebtAmount: 0, valueToReceive: 0,  profileImageUrl: "batman")
}

