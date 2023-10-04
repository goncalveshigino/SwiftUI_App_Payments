//
//  PagarDividasApp.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 21/09/23.
//

import SwiftUI
import Firebase


@main
struct PagarDividasApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @StateObject var viewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

//
//class Conta {
//
//    var saldo: Double = 0
//
//
//    func depositar(_ valor: Double) {
//        saldo += valor
//    }
//
//    func emprestar(_ contaDestino: Conta,_ valor: Double) -> Double {
//
//        if saldo >= 10 {
//            saldo -= valor
//            contaDestino.depositar(valor)
//        }
//        print("Valor apos a transferencia \(saldo)")
//
//        return saldo
//    }
//
//
//
//}
