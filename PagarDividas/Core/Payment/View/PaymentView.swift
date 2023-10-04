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
    let user: User
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: PaymentViewModel(user: user))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if user.debit {
                Text(user.debt, format: .currency(code: "USD"))
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
            
            Spacer()
            
            TextField("Transferir", value: $viewModel.transfer, format: .number )
              .keyboardType(.decimalPad)
              .multilineTextAlignment(.center)
              .font(.system(size: 30))
              .bold()
            
            Text("FROM")
                .bold()
                .padding(.top, 40)
            
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray)
                .frame(width: 340, height: 60)
                .overlay() {
                    VStack(alignment: .trailing) {
                        
                       
                        HStack {
                            CircularProfileImageView(user: user, size: .xSmall)
//                            Image(systemName: "person.circle")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 40, height: 40)
//                                .foregroundColor(.black)
                            
                            
                            Text(user.fulName)
                                .font(.title3)
                                .bold()
                            
                             Spacer()
                        }
                        .padding(.horizontal, 30)
                          
                    }
                }
            
            Text("TO")
                .bold()
                .padding(.top, 20)
            
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray)
                .frame(width: 340, height: 60)
                .overlay() {
                    VStack(alignment: .trailing) {
                        
                        HStack {
                            CircularProfileImageView(user: user, size: .xSmall)
//                            Image(systemName: "person.circle")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 40, height: 40)
//                                .foregroundColor(.black)
                            
                            
                            Text(user.fulName)
                                .font(.title3)
                                .bold()
                            
                             Spacer()
                        }
                        .padding(.horizontal, 30)
                          
                    }
                    
                    
                    
                  Button {
                       viewModel.sendTransfer()
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
                   .padding(.top, 180)
                   .padding(.leading, 30)
                   .padding(.trailing, 30)
                }
            
            Spacer()

            
/*
//
//
//            VStack {
//                Text(user.fulName)
//                    .font(.headline)
//                    .font(.title)
//                Text(user.email)
//            }
//            .padding(.top, 20)
            
            
            
            
//            if user.debit == true {
//                Image(systemName: "train.side.front.car")
//            }
            */

      
                 
        }
        .navigationBarTitle(user.debit ? "Divida Existente" : "Transferencia")
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
    
  

