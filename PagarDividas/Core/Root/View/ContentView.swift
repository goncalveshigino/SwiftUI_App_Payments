//
//  ContentView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 21/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()

    

    var body: some View {
        Group {
            if viewModel.userSession != nil {
               HomeView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
