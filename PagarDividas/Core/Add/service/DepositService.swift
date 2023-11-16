//
//  DepositService.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 15/11/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class DepositService {
    
    func deposit(_ saldo: Double){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
         
        FirestoreConstants.UserCollection
            .document(uid)
            .updateData([User.CodingKeys.saldo.rawValue: FieldValue.increment(saldo)])
        
    }
}
