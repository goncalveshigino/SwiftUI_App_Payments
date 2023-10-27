//
//  LendView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 27/10/23.
//

import SwiftUI

struct LendView: View {
    
    @StateObject var viewModel: PaymentViewModel
    @Environment(\.dismiss) var dismiss
    @State var isLending: Bool = false
    
    let user: User
    
    
    private var user1: User? {
        return viewModel.currentUser
    }
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: PaymentViewModel(user: user))
    }
    
    var canAddDecimal: Bool {
        viewModel.transfer.filter({$0 == "."}).count == 0 ? true : false
    }
    
    var canAddDigit: Bool {
        guard let decIndex = viewModel.transfer.firstIndex(of: ".") else { return true }
        let index = viewModel.transfer.distance(from: viewModel.transfer.startIndex, to: decIndex)
        return (viewModel.transfer.count - index - 1) < 2
    }
    
    var body: some View {
            VStack {
                
                
                
                Text(user.debt ? "Pagar Divida" : "Emprestar")
                    .font(.system(size: 30))
                    .bold()
                    .multilineTextAlignment(.leading)
                    
                
                Spacer()
                
                TextField("Transferir", text: $viewModel.transfer)
                    .font(.system(size: 70))
                    .frame(width: 250)
                    .padding(.vertical, 1)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.trailing)
                
                
                    LazyVGrid(columns: Array(repeating: .init(.fixed(80)), count: 3)){
                        ForEach(1...9, id: \.self) { index in
                            numberButton(number: "\(index)")
                        }
                    }

                
                HStack {
                    numberButton(number: "0")
                    numberButton(number: ".")
                    Button {
                        if viewModel.transfer.count == 1 {
                            viewModel.transfer = "0"
                            isLending = false
                        } else {
                            viewModel.transfer.removeLast()
                        }
                    } label: {
                        Image(systemName: "delete.backward.fill")
                            .font(.largeTitle)
                            .bold()
                            .frame(width: 80, height: 80)
                            .background(.gray)
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    }
                }
                
              
                Button {
                    viewModel.sendTransfer()
                    dismiss()
                 } label: {
                     HStack {
                         
                         Text("Transferir")
                             .font(.title2)
                             .fontWeight(.semibold)
                         
                     }
                     .foregroundColor(.white)
                     .frame(width: 232, height: 48)
                 }
                 .disabled(Double(viewModel.transfer) == 0)
                 .background(isLending ? .blue : .gray)
                 .cornerRadius(10)
                 .padding(.top, 24)
                 .padding(.horizontal, 60)
                
                Spacer(minLength: 20)
                
        }
    }
    
    func addDigit(_ number: String) {
        if canAddDigit {
            if number == "." {
                if canAddDecimal {
                    viewModel.transfer += number
                }
            } else {
                viewModel.transfer = viewModel.transfer == "0" ? number : viewModel.transfer + number
            }
        }
    }
    
    
    func numberButton(number: String) -> some View {
        Button(action: {
            isLending = true
            addDigit(number)
        }, label: {
            Text(number)
                .font(.largeTitle)
                      .bold()
                      .frame(width: 80, height: 80)
                      .background(Color.accentColor)
                      .foregroundStyle(.white)
                      .clipShape(Circle())
       })
    }
}

#Preview {
    LendView(user: .MOCK_USER)
}
