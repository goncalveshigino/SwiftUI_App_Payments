//
//  RowEmprestimo.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 25/09/23.
//

import SwiftUI

struct RowEmprestimo: View {
    let payment: Payment
    
    
//    static let currencyFormatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        
//        formatter.maximumIntegerDigits = 10
//        formatter.maximumFractionDigits = 2
//        
//        return formatter
//    }()
    
    var body: some View {
        HStack {
            
            CircularProfileImageView(user: payment.user, size: .xSmall)

            
            VStack(alignment: .leading) {
                Text(payment.user?.fulName ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("10 Set 2023 at 1:30 PM")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            payment.isFromCurrentUser 
            ? Text("- \(payment.transfer, format: .currency(code: "USD"))")
                .font(.footnote)
                .bold()
                .foregroundColor(.red)
            
            : Text("+ \(payment.transfer, format: .currency(code: "USD"))")
                .font(.footnote)
                .bold()
                .foregroundColor(.green)
        
        }
        
        Divider()
            .padding(.horizontal, 40)
    }
}

//struct RowEmprestimo_Previews: PreviewProvider {
//    static var previews: some View {
//        RowEmprestimo()
//    }
//}
