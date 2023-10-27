//
//  RowEmprestimo.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 25/09/23.
//

import SwiftUI

struct RowEmprestimo: View {
    let payment: Payment
    
    
    let identifier = Locale.current.currency?.identifier ?? ""
    
    var body: some View {
        HStack {
            
            CircularProfileImageView(user: payment.user, size: .xSmall)

            
            VStack(alignment: .leading) {
                Text(payment.user?.fulName ?? User.MOCK_USER.fulName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(payment.timestampString)
                    .font(.footnote)
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            payment.isFromCurrentUser 
            ? Text("- \(payment.transfer.angolanMoneyFormatWithoutCurrency())")
                .font(.footnote)
                .bold()
                .foregroundColor(.red)
            
            : Text("+ \(payment.transfer.angolanMoneyFormatWithoutCurrency())")
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
