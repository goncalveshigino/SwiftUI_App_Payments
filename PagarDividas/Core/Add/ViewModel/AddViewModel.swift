//
//  AddViewModel.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 22/09/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AddViewModel: ObservableObject {

    @Published var saldo: Double = 0.0
    @Published var showAlert = false




    func salvar(){

        guard let uid = Auth.auth().currentUser?.uid else { return }

        FirestoreConstants.UserCollection
            .document(uid)
            .updateData([User.CodingKeys.saldo.rawValue: FieldValue.increment(saldo)])
    }

}
