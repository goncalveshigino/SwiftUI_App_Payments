//
//  Home.swift
//  KeyBoardCustom
//
//  Created by Goncalves Higino on 27/09/23.
//

import SwiftUI

struct Home: View {
    @State private var text: String = ""
    @FocusState private var showKeyboard: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            
            Text("Goncalves Luis")
            Text("goncalves@gmail.com")
            
            TextField("Kz 500", text: $text)
//                .inputView {
//                   CustomKeyboardView()
//                }
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .environment(\.colorScheme,.light)
            
            Spacer()
            
            CustomKeyboardView()
                .padding(.bottom,30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(Color.white.gradient)
                .ignoresSafeArea()
        }
        
    }
    //Custom keyboard
    @ViewBuilder
    func CustomKeyboardView() -> some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10), count: 3), spacing: 10){
            ForEach(1...9, id: \.self) { index in
                keyboardButtonView(.text("\(index)")) {
                    //Adding Text
                    //Adding Dollar in front
                    if text.isEmpty {
                        text.append("$")
                    }
                    text.append("\(index)")
                }
            }
            //Other Button's With Zero in Center
            keyboardButtonView(.text(".")) {
             
                if text.isEmpty {
                    text.append("$")
                }
                text.append(".")
            }
            
            keyboardButtonView(.text("0")) {
                if text.isEmpty {
                    text.append("$")
                }
                text.append("0")
            }
            
            keyboardButtonView(.image("delete.backward")) {
                //Closing Keyboard
                showKeyboard = false
            }
            Button {
               
            } label: {
                HStack {
                    Text("Transferir")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: 232, height: 48)
            }
            .background(Color(.systemBlue))
            .cornerRadius(10)
            .padding(.top, 2)
            .padding(.leading, 260)
            .padding(.horizontal)
            
        }
        .padding(.horizontal,15)
        .padding(.vertical,5)
        .background {
            Rectangle()
                .fill(Color.white.gradient)
                .ignoresSafeArea()
        }
    }
    
    //Keyboard Button View
    @ViewBuilder
    func keyboardButtonView(_ value: KeyboardValue, onTap: @escaping () -> ()) -> some View {
        Button(action: onTap) {
            ZStack {
                switch value {
                case .text(let string):
                    Text(string)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                case .image(let image):
                    Image(systemName: image)
                        .font(image == "checkmark.circle.fill" ? .title : .title2)
                        .fontWeight(.semibold)
                        .foregroundColor(image == "checkmark.circle.fill" ? .green : .black)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .contentShape(Rectangle())
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Home()
        }
    }
}

//Enum Keyboard Value
enum KeyboardValue {
    case text(String)
    case image(String)
}

//ZStack {
//    Color.red
//
//    VStack {
//        Button("Close Keyboard") {
//            showKeyboard = false
//        }
//
//        Text(text)
//
//        Button("Add 123") {
//            text.append("123")
//        }
//    }
//}
//.frame(maxWidth: .infinity)
//.frame(height: 300)
