//
//  HeaderHomeView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 25/09/23.
//

import SwiftUI

struct HeaderHomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    private var user: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        HStack{
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.blue)
            
                
            Text("Goncalves Higino")
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .foregroundColor(.green)
                .frame(width: 30, height: 30)
            
        }
        .navigationDestination(for: User.self, destination: { user in
            ProfileView(user: user)
        })
        .aspectRatio(3.0, contentMode: .fit)
    }
}

struct HeaderHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderHomeView()
    }
}

