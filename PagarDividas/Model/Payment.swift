//
//  Payment.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 28/09/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Payment: Identifiable, Codable, Hashable {
    
    @DocumentID var paymentId: String?
    let fromId: String
    let toId: String
    let transfer: Double
    let timestamp: Timestamp
    
    var user: User?
    
    var id: String {
        return paymentId ?? NSUUID().uuidString
    }
    
    var paymentPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    var isFromCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
    
    var timestampString: String {
        return timestamp.dateValue().timestampString()
    }
    
    enum CodingKeys: String, CodingKey {
        case paymentId
        case fromId
        case toId
        case transfer
        case timestamp
        case user
    }
}
