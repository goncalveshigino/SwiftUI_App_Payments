//
//  Constants.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 28/09/23.
//

import Foundation
import Firebase

struct FirestoreConstants {
    
    static let UserCollection = Firestore.firestore().collection("users")
    static let PaymentCollection = Firestore.firestore().collection("payments")
}
