//
//  HomeService.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 30/09/23.
//

import Foundation
import Firebase


class HomeService {
    
    @Published var documentChanges = [DocumentChange]()
    
 
    
    func observeRecentPayments() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = FirestoreConstants
            .PaymentCollection
            .document(uid)
            .collection("recent-payments")
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot,_ in
            guard let changes = snapshot?.documentChanges.filter({
                $0.type == .added || $0.type == .modified
            }) else { return }
            
            self.documentChanges = changes
        }
    }
    
    
    
    
    
}
