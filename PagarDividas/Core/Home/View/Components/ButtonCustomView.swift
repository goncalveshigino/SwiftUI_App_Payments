//
//  ButtonCustomView.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 02/10/23.
//

import SwiftUI

struct ButtonCustomView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .stroke(Color.gray)
            .frame(width: 240, height: 40)
            .overlay() {
                Button {
                    action()
                } label: {
                    Text(title)
                        .foregroundColor(Color.white)
                        .bold()
                }
            }
    }
}

struct ButtonCustomView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonCustomView(title: "gdgdgd") {
            
        }
    }
}
