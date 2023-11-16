//
//  CardDebtUserView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 01/11/23.
//

import SwiftUI

struct CardDebtUserView: View {
    
    @State var selection: String = ""
    @State private var showSheet: Bool = false
    @StateObject var viewModel: PaymentViewModel

    
    let user: User
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: PaymentViewModel(user: user))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack {
                
                HStack(spacing: 10) {
                   Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Text(user.fulName)
                        .font(.system(size: 20, weight: .semibold))
                    
                     Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        Color(UIColor.secondarySystemBackground)
                    )
                    .frame(width: 350, height: 200)
                    .overlay(
                        VStack {
                            HStack {
                               Circle()
                                    .stroke(Color.blue.opacity(0.3),  lineWidth: 15)
                                    .frame(width: 120, height: 100)
                                    .overlay(alignment: .center) {
                                        Text("0%")
                                            .foregroundStyle(.blue)
                                    }
                                    .padding(.top)
                                
                                Spacer()
                                
                                
                                if user.debt {
                                    Button("Quitar Divida") {
                                        showSheet.toggle()
                                    }
                                    .sheet(isPresented: $showSheet, content: {
                                        LendView(user: user)
                                     })
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .padding(.horizontal, 20)
                                    .background(
                                        Color.blue
                                            .cornerRadius(10)
                                            .shadow(radius: 10)
                                    )
                                } else {
                                    Button("Emprestar") {
                                        viewModel.addUserDebt()
                                        showSheet.toggle()
                                    }
                                    .sheet(isPresented: $showSheet, content: {
                                        LendView(user: user)
                                     })
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .padding(.horizontal, 20)
                                    .background(
                                        Color.blue
                                            .cornerRadius(10)
                                            .shadow(radius: 10)
                                    )
                                }
                                
                                  
                            }
                            .padding(.horizontal, 20)
                            
                            Divider()
                                .padding(.top, 10)
                            
                            HStack {
                                Text("Divida existente")
                                    .font(.system(size: 14, weight: .semibold))
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 1)
                                    .padding(.bottom,4)
                                   
                                Spacer()
                                Text(user.totalDebtAmount.angolanMoneyFormatWithoutCurrency())
                                    .font(.system(size: 14, weight: .bold))
                                    .bold()
                            }
                            .padding(.horizontal, 20)
                        }
                    )
            }
         
            Text("Transferencias")
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal, 20)
                .padding(.top, 10)
            
            
            ScrollView {
                ForEach(viewModel.payments){ payment in
                    RowEmprestimo(payment: payment, viewModel: viewModel)
                }
                .padding(.horizontal, 20)
            }
            Spacer()
            
        }
      }
}


#Preview {
    CardDebtUserView(user: .MOCK_USER)
        .previewLayout(.sizeThatFits)
}
