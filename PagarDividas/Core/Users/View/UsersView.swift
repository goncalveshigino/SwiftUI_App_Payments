//
//  UsersView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 22/09/23.
//

import SwiftUI

struct UsersView: View {
    
    @Binding var seletedUser: User?
    @StateObject var viewModel = UserViewModel()
    @Environment(\.dismiss) var dismiss
  

 
    
    var body: some View {
        NavigationStack {
            ScrollView {
                  LazyVStack(spacing: 12) {
                      ForEach(viewModel.users) { user in
                          VStack {
                              HStack {
                                  CircularProfileImageView(user: user, size: .small)
                                  
                                  Text(user.fulName)
                                      .font(.subheadline)
                                      .fontWeight(.semibold)
                                       
                                  Spacer()
                                  
                              }
                              .padding(.leading)
                              
                              Divider()
                                  .padding(.leading, 40)
                          }
                              .onTapGesture {
                                  seletedUser = user
                                  dismiss()
                              }
                              .foregroundColor(.black)
                              .padding(.horizontal)
                      }
                  
                  }
                  .navigationTitle("Usuarios")
                  .navigationBarTitleDisplayMode(.inline)
                  .toolbar {
                      ToolbarItem(placement: .navigationBarLeading) {
                          Button("Cancel") {
                              dismiss()
                          }
                          .foregroundColor(.black)
                      }
                      
                      ToolbarItem(placement: .navigationBarTrailing) {
                          Menu("Filter \(viewModel.selectedFilter?.rawValue ?? "")") {
                              ForEach(UserViewModel.FilterOption.allCases, id: \.self) { option in
                                  Button(option.rawValue) {
                                      Task {
                                          try await viewModel.filterSelected(option: option)
                                      }
                                  }
                              }
                          }
                      }
                  }
                  .padding(.top, 8)
            }
        }
    }
}


struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UsersView(seletedUser: .constant(User.MOCK_USER))
        }
    }
}
