//
//  PaymentViewModel.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 27/09/23.
//

import Foundation
import Firebase
import Combine

class PaymentViewModel: ObservableObject {
    
    @Published var transfer = "0"
    @Published var isDebt: Bool = false
    @Published var payments = [Payment]()
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    
    
    let service: PaymentService

    init(user: User) {
        self.service = PaymentService(paymentPartner: user)
        obeservePayment()
        setUpSubscribers()
    }
    
    private func setUpSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
    }
    
    func sendTransfer() {
        if currentUser?.saldo ?? 0 > 10 {
            service.sendtransfer(Double(transfer) ?? 0)
        }
    }
    
    
    func obeservePayment() {
        service.observePayment() { payments in
            self.payments.append(contentsOf: payments)
        }
    }
    
    func addUserDebt() {
        Task {
            try? await service.addUserDebt(amount: 0, isDebt: false)
        }
    }
    
    func payUserDebt() {
        service.payUserDebt(Double(transfer) ?? 0)
    }
    
}
