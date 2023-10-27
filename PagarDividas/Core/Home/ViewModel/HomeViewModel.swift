//
//  HomeViewModel.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 25/09/23.
//

import Foundation
import Combine
import Firebase

class HomeViewModel: ObservableObject {
    
   
    @Published var currentUser: User?
    @Published var recentPayments = [Payment]()
    
    
    
    private var cancellables = Set<AnyCancellable>()
    private let service = HomeService()
    
    
    init() {
        setUpSubscribers()
        service.observeRecentPayments()
    }
    
    private func setUpSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
        
        service.$documentChanges.sink { [weak self] changes in
            self?.loadInitialPayments(fromChanges: changes)
        }.store(in: &cancellables)
    }
    
    private func loadInitialPayments(fromChanges changes: [DocumentChange]) {
        var payments = changes.compactMap({ try? $0.document.data(as: Payment.self)})
        
        for i in 0..<payments.count {
            let payment = payments[i]
            
            UserService.fetchUser(withUid: payment.paymentPartnerId) { user in
                payments[i].user = user
                self.recentPayments.append(payments[i])
            }
        }
    }
}
