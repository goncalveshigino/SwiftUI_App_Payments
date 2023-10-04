//
//  HomeTView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 02/10/23.
//

import SwiftUI

struct HomeTView: View {
    
    
    @StateObject var viewModel = HomeViewModel()
    @State private var showNewUserView = false
    @State private var seletedUser: User?
    @State private var showScreenTransf = false
    
    
    private var user: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ZStack {
                
               RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(.white)
                   .rotationEffect(Angle())
                   .overlay() {
                       VStack {
                           Text("$ 500,000")
                               .font(.system(size: 50))
                               .foregroundColor(Color.white)
                               .bold()
                           
                           Text("Saldo da conta")
                               .font(.subheadline)
                               .foregroundColor(Color.white)
                           
                           HStack {
                               
                               ButtonViewCustom(title: "Depositar")
                                   .padding(.horizontal, 10)
                               
                               
                               ButtonViewCustom(title: "Tranferir")
                           }

                           .padding(.top, 20)
                       }
                       .padding(.top, 130)
                   }
                
                
                
           }
           .frame(width: UIScreen.main.bounds.width * 3,height: 350)
           .offset(y: -60)
            
            Text("Tranferencias recentes")
                .font(.title3)
                .padding(.top, 20)
           
            
        
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.recentPayments) { payment in
                    RowEmprestimo(payment: payment)
                }
            }
            Spacer()
            
      
            
        }
    }
}

struct HomeTView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTView()
    }
}

struct ButtonViewCustom: View {
    let title: String
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(Color.gray)
            .frame(width: 150, height: 40)
            .overlay() {
                Button {
                    
                } label: {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    
                }
                
            }
    }
}
