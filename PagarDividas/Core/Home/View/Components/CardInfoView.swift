//
//  CardInfoView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 25/09/23.
//

import SwiftUI

struct CardInfoView: View {
    @State private var showNewUserView = false
    @State private var seletedUser: User?
    
    
    var body: some View {
            
    ZStack {
        
        Rectangle()
               .foregroundColor(.blue)
               .cornerRadius(15)
               .frame(width: 370, height: 220)
               .overlay(){
                   VStack {
                       Text("$ 500,000")
                           .font(.system(size: 50))
                           .foregroundColor(Color.white)
                           .bold()
                       
                       Text("Saldo da conta")
                           .font(.subheadline)
                           .foregroundColor(Color.white)
                       
                       HStack {
                           
                           ButtonCustomView(title: "Depositar") {
                            
                           }
                               
                           ButtonCustomView(title: "Tranferir"){
                              
                           }
                       }

                       .padding(.top, 20)
                   }
                   .padding(.top, 20)
               }
            }
        }
    }



struct CardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CardInfoView()
            .previewLayout(.sizeThatFits)
    }
}
