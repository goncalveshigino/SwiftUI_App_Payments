//
//  HomeView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 25/09/23.
//

import SwiftUI

struct HomeView: View {
    
    
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
                
            Rectangle()
                   .foregroundColor(.blue)
                   .cornerRadius(15)
                   .frame(width: 370, height: 220)
                   .overlay(){
                       VStack {
                           Text("$ \(user?.saldo ?? 0, format: .number)")
                               .font(.system(size: 50))
                               .foregroundColor(Color.white)
                               .bold()
                           
                           Text("Saldo da conta")
                               .font(.subheadline)
                               .foregroundColor(Color.white)
                           
                           HStack {
                               
                               RoundedRectangle(cornerRadius: 0)
                                   .stroke(Color.gray)
                                   .frame(width: 140, height: 40)
                                   .overlay() {
                                       NavigationLink {
                                           AddView()
                                       } label: {
                                           Text("Depositar")
                                               .foregroundColor(Color.white)
                                               .bold()
                                       }
                                   }
                                   
                               ButtonCustomView(title: "Tranferir"){
                                   showNewUserView.toggle()
                                   seletedUser = nil
                               }
                           }

                           .padding(.top, 20)
                       }
                       .padding(.top, 20)
                   }
                }
                .padding(.top, 60)
               
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
        .onChange(of: seletedUser, perform: { newValue in
            showScreenTransf = newValue != nil
        })
        .navigationDestination(for: User.self, destination: { user in
            ProfileView(user: user)
        })
        .navigationDestination(isPresented: $showScreenTransf, destination: {
            if let user = seletedUser {
              PaymentView(user: user)
            }
        })
        .fullScreenCover(isPresented: $showNewUserView, content: {
            UsersView(seletedUser: $seletedUser)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading ) {
                HStack {
                    NavigationLink(value: user) {
                        CircularProfileImageView(user: user, size: .xSmall)
                    }

                    Text( user?.fulName ?? "")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showNewUserView.toggle()
                    seletedUser = nil
                } label: {
                    Image(systemName: "square.and.pencil.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.black, Color(.systemGray5))
                }
            }
        }
       .padding(.horizontal, 30)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}
