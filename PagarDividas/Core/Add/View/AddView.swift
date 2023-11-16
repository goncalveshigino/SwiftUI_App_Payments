//

//
//  LendView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 27/10/23.
//

import SwiftUI



struct DepositView: View {
    
    @StateObject var viewModel = DepositViewModel()
    @Environment(\.dismiss) var dismiss
    @State var isLending: Bool = false

    
    let user: User
    
    
    var canAddDecimal: Bool {
        viewModel.saldo.filter({$0 == "."}).count == 0 ? true : false
    }
    
    var canAddDigit: Bool {
        guard let decIndex = viewModel.saldo.firstIndex(of: ".") else { return true }
        let index = viewModel.saldo.distance(from: viewModel.saldo.startIndex, to: decIndex)
        return (viewModel.saldo.count - index - 1) < 2
    }
    
    var body: some View {
            VStack {
                
            
                TextField("", text: $viewModel.saldo)
                    .font(.system(size: 70))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 1)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(.black)
                    .background(.blue.opacity(0.3))
                
                Spacer()
                
                
                    LazyVGrid(columns: Array(repeating: .init(.fixed(80)), count: 3)){
                        ForEach(1...9, id: \.self) { index in
                            numberButton(number: "\(index)")
                        }
                    }

                
                HStack {
                    numberButton(number: "0")
                    numberButton(number: ".")
                    Button {
                        if viewModel.saldo.count == 1 {
                            viewModel.saldo = "0"
                            isLending = false
                        } else {
                            viewModel.saldo.removeLast()
                        }
                    } label: {
                        Image(systemName: "delete.backward.fill")
                            .font(.largeTitle)
                            .bold()
                            .frame(width: 80, height: 80)
                            .background(.blue.opacity(0.3))
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                    }
                }
                
              
                Button {
                    viewModel.deposit()
                    dismiss()
                 } label: {
                     HStack {
                         
                         Text("Depositar")
                             .font(.title2)
                             .fontWeight(.semibold)
                         
                     }
                     .foregroundColor(.white)
                     .frame(width: 232, height: 48)
                 }
                 .disabled(Double(viewModel.saldo) == 0)
                 .background(isLending ? .blue : .gray)
                 .cornerRadius(10)
                 .padding(.top, 24)
                 .padding(.horizontal, 60)
                
                Spacer(minLength: 20)
                
        }
        .presentationDetents([.fraction(0.8)])
        .presentationDragIndicator(.hidden)
    }
    
    func addDigit(_ number: String) {
        if canAddDigit {
            if number == "." {
                if canAddDecimal {
                    viewModel.saldo += number
                }
            } else {
                viewModel.saldo = viewModel.saldo == "0" ? number : viewModel.saldo + number
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
    NavigationStack {
        DepositView(user: .MOCK_USER)
    }
}
