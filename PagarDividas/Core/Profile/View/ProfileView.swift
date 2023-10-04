//
//  ProfileView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 21/09/23.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    let user: User
    
    var body: some View {
    VStack{
        
        VStack {
            PhotosPicker(selection: $viewModel.selectedItem) {
                if let profileImage = viewModel.profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                } else {
                    CircularProfileImageView(user: user,size: .large)
                }
            }
            
            Text(user.fulName)
                .font(.footnote)
                .padding(.top, 4)
            
            Text(user.email)
                .font(.footnote)
                .foregroundColor(.gray)
                        
        }
        
        List {
            Section("Account") {
                
                Button {
                    AuthService.shared.signOut()
                } label: {
                    SettingsRowView(imageName: "arrow.left.circle.fill",
                                    title: "Terminar",
                                    tintColor: .red)
                }
                
                Button {
                    print("Delete account")
                } label: {
                    SettingsRowView(imageName: "xmark.circle.fill",
                                    title: "Apagar a conta",
                                    tintColor: .red)
                }
            }
        }
                    
        
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView(user: User.MOCK_USER)
        }
    }
}
