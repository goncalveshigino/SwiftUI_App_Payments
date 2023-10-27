//
//  PaymentView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 27/09/23.
//

import SwiftUI

struct PaymentView: View {
    
    @FocusState private var showKeyboard: Bool
    @StateObject var viewModel: PaymentViewModel
    @Environment(\.dismiss) var dismiss
    
    let user: User
    
    
    private var user1: User? {
        return viewModel.currentUser
    }
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: PaymentViewModel(user: user))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
         
            
            Spacer()
            
            //TextField("Transferir", value: $viewModel.transfer, format: .number )
            TextField("Transferir", text: $viewModel.transfer)
              .keyboardType(.decimalPad)
              .multilineTextAlignment(.center)
              .font(.system(size: 30))
              .bold()
              .padding(.bottom, 50)
            
            Text("De")
                .bold()
                .padding(.top, 40)
            
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray)
                .frame(width: 340, height: 60)
                .overlay() {
                    VStack(alignment: .trailing) {
                        
                        HStack {
                            CircularProfileImageView(user: user1, size: .xSmall)
                            Text(user1?.fulName ?? "")
                                .font(.title3)
                                .bold()
                            
                            
                             Spacer()
                        }
                        .padding(.horizontal, 30)
                          
                    }
                }
            
            Text("Para")
                .bold()
                .padding(.top, 20)
            
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray)
                .frame(width: 340, height: 60)
                .overlay() {
                    VStack(alignment: .trailing) {
                        
                        HStack {
                            CircularProfileImageView(user: user, size: .xSmall)
                            
                            Text(user.fulName)
                                .font(.title3)
                                .bold()
                            
                            
                             Spacer()
                        }
                        .padding(.horizontal, 30)
                          
                    }
                    .contextMenu {
                        Button("Emprestar") {
                            viewModel.addUserDebt()
                        }
                    }
                }
            
            
         
            if user.debt {
                Button {
                    viewModel.payUserDebt()
                    dismiss()
                 } label: {
                     HStack {
                         
                         Text("Pagar Dividas")
                             .fontWeight(.semibold)
                         Image(systemName: "arrow.right")
                     }
                     .foregroundColor(.white)
                     .frame(width: 232, height: 48)
                 }
                 .background(Color(.systemBlue))
                 .cornerRadius(10)
                 .padding(.top, 10)
                 .padding(.leading, 60)
                 .padding(.trailing, 30)

            } else {
                Button {
                    viewModel.sendTransfer()
                    dismiss()
                 } label: {
                     HStack {
                         
                         Text("Transferir")
                             .fontWeight(.semibold)
                         Image(systemName: "arrow.right")
                     }
                     .foregroundColor(.white)
                     .frame(width: 232, height: 48)
                 }
                 .background(Color(.systemBlue))
                 .cornerRadius(10)
                 .padding(.top, 10)
                 .padding(.leading, 60)
                 .padding(.trailing, 30)

            }
            
            Spacer()

            
       /*
        if user.debit == true {
              Image(systemName: "train.side.front.car")
        }*/

      
                 
        }
        .navigationBarTitle(user.debt ? "Divida Existente" : "Emprestimo")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 40)
    }
}
       

    struct PaymentView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack {
                PaymentView(user: User.MOCK_USER)
                    .previewLayout(.sizeThatFits)
            }
        }
    }
    
  

