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
        VStack {
            
            
            CircularProfileImageView(user: user, size: .large)
      
            
            VStack {
                Text(user.fulName)
                    .font(.headline)
                    .font(.title)
                Text(user.email)
            }
            .padding(.top, 20)
            
            
            
            
//            if user.debit == true {
//                Image(systemName: "train.side.front.car")
//            }
            

            Form {
                
                TextField("Transferir", value: $viewModel.transfer, format: .number )
                  .keyboardType(.decimalPad)
                  .multilineTextAlignment(.center)
                  .font(.system(size: 30))
                  .bold()
                
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
                 .padding(.top, 2)
                 .padding(.leading, 30)
                 .padding(.trailing, 30)
                 
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(Color.white.gradient)
                .ignoresSafeArea()
        }
    }
}
       

    struct PaymentView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack {
                PaymentView(user: User.MOCK_USER)
            }
        }
    }
    
  

