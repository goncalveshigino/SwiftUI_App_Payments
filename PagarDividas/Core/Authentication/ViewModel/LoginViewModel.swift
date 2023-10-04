//
//  LoginViewModel.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 27/09/23.
//

import SwiftUI

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func login() async throws {
        try await AuthService.shared.login(WithEmail: email, password: password)
    }
}
