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
        VStack(alignment: .leading){
            
            if let user = user {
                Text(user.saldo.angolanMoneyFormatWithoutCurrency())
                    .font(.system(size: 30, weight: .bold))
            }
            

            
            Spacer()
            
           
         Text("Devidas e Emprestimos")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 20)
                    .multilineTextAlignment(.leading)
           
                
            HStack {
                CardDebtView(title: "Quantos eu devo?")
                Spacer()
                CardDebtView(title: "Quantos me devem?")
            }
               
               
            Text("Emprestimo recentes")
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 20)
           
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.recentPayments) { payment in
                    RowEmprestimoRescent(payment: payment)
                }
               
            }
            .refreshable {
                await viewModel.handRefresh()
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
                //PaymentView(user: user)
              // LendView(user: user)
               CardDebtUserView(user: user)
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

                    Text( user?.fulName ?? User.MOCK_USER.fulName)
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

struct CardDebtView: View {
    let title: String
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.blue)
                .cornerRadius(15)
                .frame(width: 180, height: 220)
                .overlay(){
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.headline)
                            .padding(.top, 20)
                            .foregroundStyle(.white)
                        
                        Text("10")
                            .font(.system(size: 36, weight: .semibold))
                            .foregroundStyle(.gray)
                        
                        Rectangle()
                            .fill(.white)
                            .frame(width: 166, height: 120)
                            .cornerRadius(15)
                            .padding(.bottom)
                            .overlay(){
                                VStack {
                                    Text("Total")
                                        .font(.system(size: 20, weight: .semibold))
                                        .padding(.bottom,5)
                                        .multilineTextAlignment(.center)
                                    
                                    Text("50.000.00")
                                        .font(.system(size: 26, weight: .bold))
                                        .padding(.horizontal, 10)
                                        .multilineTextAlignment(.trailing)
                                        .minimumScaleFactor(0.7)
                                }
                            }
                    }
                }
        }
    }
}
