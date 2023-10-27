//
//  Double.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 27/10/23.
//

import Foundation


extension Double {
//    func angolanMoneyFormat() -> String {
//        return "\(String(format: "%.2f", locale: Locale(identifier: "pt"), ))"
//    }
    
    func angolanMoneyFormatWithoutCurrency() -> String {
        return "\(String(format: "%.2f", locale: Locale(identifier: "pt"), self))"
    }
    
    func withTwoDecimals() -> String {
        return String(format: "%.2f", self)
    }
    
    func withOneDecimals() -> String {
        return String(format: "%.1f", self)
    }
}
