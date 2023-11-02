//
//  AddView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 22/09/23.
//

import SwiftUI

struct AddView: View {
    
    @StateObject var viewModel = AddViewModel()
    @Environment(\.dismiss) var dismiss
    @State var isLending: Bool = false
    @State var saldo: String = "0"
    
   
    
    
    var canAddDecimal: Bool {
        saldo.filter({$0 == "."}).count == 0 ? true : false
    }
    
    var canAddDigit: Bool {
        guard let decIndex = saldo.firstIndex(of: ".") else { return true }
        let index = saldo.distance(from: saldo.startIndex, to: decIndex)
        return (saldo.count - index - 1) < 2
    }
    
    var body: some View {
            VStack {
            
                Spacer()
                
                TextField("",value: $viewModel.saldo, format: .number)
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
                        if saldo.count == 1 {
                            saldo = "0"
                            isLending = false
                        } else {
                            saldo.removeLast()
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
                    viewModel.salvar()
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
                 .disabled(Double(saldo) == 0)
                 .background(isLending ? .blue : .gray)
                 .cornerRadius(10)
                 .padding(.top, 24)
                 .padding(.horizontal, 60)
                
                Spacer(minLength: 20)
                
        }
            .navigationTitle("Depositar")
    }
    
    func addDigit(_ number: String) {
        if canAddDigit {
            if number == "." {
                if canAddDecimal {
                    saldo += number
                }
            } else {
                saldo = saldo == "0" ? number : saldo + number
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



struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddView()
        }
    }
}


//VStack {
//                PhotosPicker(selection: $viewModel.selectedItem) {
//                    if let profileImage = viewModel.profileImage {
//                        profileImage
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 80, height: 80)
//                            .clipShape(Circle())
//                    } else {
//                        CircularProfileImageView(user: user,size: .small)
//                    }
//                }
//    
//    Image(systemName: "person.circle")
//            .resizable()
//            .scaledToFill()
//            .frame(width: 80, height: 80)
//            .clipShape(Circle())
//    
//    
//    Text("Goncalves Higino")
//        .font(.footnote)
//        .padding(.top, 4)
//        .bold()
//    
//    Text("user.email")
//        .font(.footnote)
//        .foregroundColor(.gray)
//                
//}
//
//
//
// Form {
//     
//     TextField("Saldo", value: $viewModel.saldo,format: .number)
//       .keyboardType(.decimalPad)
//       .multilineTextAlignment(.center)
//       .font(.system(size: 30))
//       .bold()
//     
//      
//     Button {
//          viewModel.salvar()
//      } label: {
//          HStack {
//              Text("Depositar")
//                  .fontWeight(.semibold)
//              Image(systemName: "arrow.right")
//          }
//          .foregroundColor(.white)
//          .frame(width: 232, height: 48)
//      }
//      .background(Color(.systemBlue))
//      .cornerRadius(10)
//      .padding(.top, 2)
//      .padding(.leading, 30)
//      .padding(.trailing, 30)
// }
//
//
//}
