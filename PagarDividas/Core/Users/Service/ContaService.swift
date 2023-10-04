//
//  ContaService.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 22/09/23.
//

import Foundation

class ContaService {
    
    func depositar(_ valor: Double) {
        saldo += valor
    }
    
    func valorEmprestado(_ contaDestino: Conta,_ valor: Double) {
          
        if saldo >= 9 {
            saldo -= valor
            contaDestino.depositar(valor)
        }
        
        print("Valor apos a transferencia \(saldo)")
        
    }
}
