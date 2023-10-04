//
//  PaymentViewModel.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 27/09/23.
//

import Foundation
import Firebase

class PaymentViewModel: ObservableObject {
    
    @Published var transfer: Double = 0.0
    @Published var payments = [Payment]()
    
    
    let service: PaymentService

    init(user: User) {
        self.service = PaymentService(paymentPartner: user)
        obeservePayment()
    }
    
    func sendTransfer() {
        service.sendtransfer(transfer)
    }
    
    func obeservePayment() {
        service.observePayment() { payments in
            self.payments.append(contentsOf: payments)
        }
    }
    
    
}
