//
//  SavedValueView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 22/09/23.
//

import SwiftUI

struct SavedValueView: View {
    @StateObject var viewModel = SavedValueViewModel()
    @Environment(\.dismiss) var dismiss
    
//    private let userId: String
//
//    init(userId: String){
//        self.userId = userId
//    }
    
    
    
    var body: some View {

        VStack {
            
            Spacer()
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.green)
        }
        .padding(.horizontal)
        .aspectRatio(3.0, contentMode: .fit)
        .navigationTitle("Pagamento")
        .toolbar {
            NavigationLink {
                AddView()
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}

struct SavedValueView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SavedValueView()
        }
    }
}
