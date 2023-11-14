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
   
    
    
    private let userCollection: CollectionReference = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private func userDebtCollection(userId: String) -> CollectionReference {
        userDocument(userId: userId).collection("user_debts")
    }
    
    
    func addUserDebt(amount: Double, isDebt: Bool) async throws {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let partnerId = paymentPartner.id
      
        let currentDebtRef = FirestoreConstants.UserCollection.document(currentUid).collection("user_debts").document(partnerId)
        let partnerDebtRef = FirestoreConstants.UserCollection.document(partnerId).collection("user_debts").document(currentUid)
        
        

        let data: [String:Any] = [
            UserDebt.CodingKeys.fromId.rawValue: currentUid,
            UserDebt.CodingKeys.toId.rawValue : partnerId,
            UserDebt.CodingKeys.isDebt.rawValue: isDebt,
            UserDebt.CodingKeys.amount.rawValue: amount
        ]
        
      
        try await currentDebtRef.setData(data)
        try await partnerDebtRef.setData(data)
    }
    
    
    func sendtransfer(_ transferValue: Double) {
        
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
        
            upadedUserDebt(value:transferValue)
        
    }
    
 
    func payUserDebt(_ value: Double) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let paymentPartnerId = paymentPartner.id
        
        FirestoreConstants.UserCollection.document(currentUid)
            .collection("user_debts").document(paymentPartnerId).updateData([UserDebt.CodingKeys.amount.rawValue: FieldValue.increment(-value)])
        
        FirestoreConstants.UserCollection.document(paymentPartnerId)
            .collection("user_debts").document(currentUid).updateData([UserDebt.CodingKeys.amount.rawValue: FieldValue.increment(-value)])
        
        updateValue(userId: paymentPartnerId, value: value)
    }

    
    
    func upadedUserDebt( value: Double) {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let paymentPartnerId = paymentPartner.id
        
        FirestoreConstants.UserCollection.document(currentUid)
            .collection("user_debts").document(paymentPartnerId).updateData([UserDebt.CodingKeys.amount.rawValue: FieldValue.increment(value)])
        
 
        FirestoreConstants.UserCollection.document(paymentPartnerId)
            .collection("user_debts").document(currentUid).updateData([UserDebt.CodingKeys.amount.rawValue: FieldValue.increment(value)])
        
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


