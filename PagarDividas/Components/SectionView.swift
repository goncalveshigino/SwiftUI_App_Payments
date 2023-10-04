//
//  SectionView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 22/09/23.
//

import SwiftUI

struct SectionView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @StateObject var userModel = UserViewModel()
    
    var body: some View {
        Section("General") {
            
            VStack {
                HStack {
                    SettingsRowView(imageName: "gear",
                                    title: "Saldo da conta",
                                    tintColor: Color(.systemGray))
                    
                    Spacer()
                    
                    Text("100")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    
                }
         
            }
        }
        
        Section("Dividas e Emprestimos") {
        
                Button {
                    Task {
                       try await  userModel.fetchAllUsers()
                    }
                } label: {
                    SettingsRowView(imageName: "person.circle.fill",
                                    title: "Pessoas a quem devi",
                                    tintColor: Color(.systemGray))
                }
              
                
                Button {
                    viewModel.signOut()
                } label: {
                    SettingsRowView(imageName: "person.circle.fill",
                                    title: "Pessoas a quem emprestei",
                                    tintColor: Color(.systemGray))

                }
        }
        
        Section("Valor por entregar e receber") {
            
            VStack {
                HStack {
                    SettingsRowView(imageName: "gear",
                                    title: "Valor por entregar",
                                    tintColor: Color(.systemGray))
                    
                    Spacer()
                    
                    Text("100")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    
                }
            
                HStack {
                
                    SettingsRowView(imageName: "gear",
                                    title: "Valor por receber",
                                    tintColor: Color(.systemGray))
                    
                    Spacer()
                    
                    Text("100")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    
                }
            }
        }

        
        Section("Account") {
            
            
            Button {
                viewModel.signOut()
            } label: {
                SettingsRowView(imageName: "arrow.left.circle.fill",
                                title: "Sign Out",
                                tintColor: .red)
            }
            
            Button {
                print("Delete account")
            } label: {
                SettingsRowView(imageName: "xmark.circle.fill",
                                title: "Delete Account",
                                tintColor: .red)
            }
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView()
    }
}
