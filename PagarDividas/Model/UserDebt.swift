//
//  UserDebt.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 06/10/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct UserDebt: Codable {
 
    @DocumentID var debtId: String?
    let fromId: String
    let toId: String
    var isDebt: Bool = false
    let amount: Double = 0
    
//    mutating func setDebt(_ state: Bool) {
//        isDebt = state
//    }
    
    var id: String {
        return debtId ?? NSUUID().uuidString
    }
    
    enum CodingKeys: String, CodingKey {
        case debtId
        case fromId
        case toId
        case isDebt
        case amount
    }
  
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self._debtId, forKey: .debtId)
        try container.encode(self.fromId, forKey: .fromId)
        try container.encode(self.toId, forKey: .toId)
        try container.encode(self.isDebt, forKey: .isDebt)
        try container.encode(self.amount, forKey: .amount)
    }
    

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._debtId = try container.decode(DocumentID<String>.self, forKey: .debtId)
        self.fromId = try container.decode(String.self, forKey: .fromId)
        self.toId = try container.decode(String.self, forKey: .toId)
    }
  
}
