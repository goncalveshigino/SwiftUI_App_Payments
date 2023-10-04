//
//  AddView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 22/09/23.
//

import SwiftUI

struct AddView: View {

    @StateObject var viewModel = AddViewModel()
    //@Binding var newValuePresented: Bool

    var body: some View {
        VStack {

            VStack {
//                PhotosPicker(selection: $viewModel.selectedItem) {
//                    if let profileImage = viewModel.profileImage {
//                        profileImage
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 80, height: 80)
//                            .clipShape(Circle())
//                    } else {
//                        CircularProfileImageView(user: user,size: .small)
//                    }
//                }
                
                Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                
                
                Text("Goncalves Higino")
                    .font(.footnote)
                    .padding(.top, 4)
                    .bold()
                
                Text("user.email")
                    .font(.footnote)
                    .foregroundColor(.gray)
                            
            }

            
    
             Form {
                 
                 TextField("Saldo", value: $viewModel.saldo,format: .number)
                   .keyboardType(.decimalPad)
                   .multilineTextAlignment(.center)
                   .font(.system(size: 30))
                   .bold()
                 
                  
                 Button {
                      viewModel.salvar()
                  } label: {
                      HStack {
                          Text("Depositar")
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
       
    }

}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddView()
        }
    }
}
