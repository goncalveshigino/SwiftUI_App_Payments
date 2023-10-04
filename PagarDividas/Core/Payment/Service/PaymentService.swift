//
//  PaymentService.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 28/09/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore


struct PaymentService {
    
    let paymentPartner: User
    
   // 946821639-Jorge
    //937808946-Jucelino
    
    func sendtransfer(_ transferValue: Double){
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let paymentPartnerId = paymentPartner.id
        
        let currentUserRef = FirestoreConstants.PaymentCollection.document(currentUid).collection(paymentPartnerId).document()
        let paymentPartnerRef = FirestoreConstants.PaymentCollection.document(paymentPartnerId).collection(currentUid)
        
        
        let recentCurrentPaymentRef = FirestoreConstants.PaymentCollection.document(currentUid).collection("recent-payments").document(paymentPartnerId)
        
        let recentPartnerPaymentRef = FirestoreConstants.PaymentCollection.document(paymentPartnerId).collection("recent-payments").document(currentUid)
        
        let paymentId = currentUserRef.documentID
        
        let payment = Payment(
            fromId: currentUid,
            toId: paymentPartnerId,
            transfer: transferValue,
            timestamp: Timestamp())
        
       
        
        guard let paymentData = try? Firestore.Encoder().encode(payment) else { return }
        
        
        currentUserRef.setData(paymentData)
        paymentPartnerRef.document(paymentId).setData(paymentData)
        
        recentCurrentPaymentRef.setData(paymentData)
        recentPartnerPaymentRef.setData(paymentData)
        
        updateValue(userId: paymentPartnerId, value: transferValue)
        
    }
    
  
    
    func updateValue(userId: String, value: Double){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        FirestoreConstants.UserCollection.document(currentUid).updateData([User.CodingKeys.saldo.rawValue: FieldValue.increment(-value)])
        FirestoreConstants.UserCollection.document(userId).updateData([User.CodingKeys.saldo.rawValue: FieldValue.increment(value)])
         
        
    }
    
    func observePayment(completion: @escaping([Payment]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let paymentPartnerId = paymentPartner.id
        
        let query = FirestoreConstants.PaymentCollection.document(currentUid).collection(paymentPartnerId).order(by:
          "timestamp", descending: false
        )
        
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({$0.type == .added}) else { return }
            var payments = changes.compactMap({try? $0.document.data(as: Payment.self)})
            
            for (index, payment) in payments.enumerated() where !payment.isFromCurrentUser {
                payments[index].user = paymentPartner
            }
            
            completion(payments)
        }
    }
    
}


