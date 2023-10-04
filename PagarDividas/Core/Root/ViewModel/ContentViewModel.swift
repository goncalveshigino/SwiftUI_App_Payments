//
//  ContentViewModel.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 27/09/23.
//

import Combine
import Firebase

class ContentViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        setUpSubscribers()
    }
    
    private func setUpSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
    }
}
