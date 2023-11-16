//
//  AddViewModel.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 22/09/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class DepositViewModel: ObservableObject {

    @Published var saldo: String = "0"
    @Published var showAlert = false
    
    var service = DepositService()

    func deposit(){
        service.deposit(Double(saldo) ?? 0)
    }

}
