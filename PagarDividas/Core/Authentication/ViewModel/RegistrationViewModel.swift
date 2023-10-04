//
//  RegistrationViewModel.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 27/09/23.
//

import SwiftUI



class RegistrationViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    @Published var saldo = 0.0
    
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullname: fullname)
    }
}
