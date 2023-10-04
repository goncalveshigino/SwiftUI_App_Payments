//
//  KeyBoardCustom.swift
//  PagarDividas
//
//  Created by Goncalves Higino on 29/09/23.
//

import SwiftUI


extension TextField {
    @ViewBuilder
    func inputView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        self.background {
            SetTFKeyboard(keyboardContent: content())
        }
    }
}

fileprivate struct SetTFKeyboard<Content: View>: UIViewRepresentable {
    var keyboardContent: Content
    @State private var hostingController: UIHostingController<Content>?
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context){
        DispatchQueue.main.async {
            if let textFieldContainerView = uiView.superview?.superview {
                if let textField = textFieldContainerView.findtextField {
                   // If the input is already set, then update it's content
                    if textField.inputView == nil {
                        //Now with the help of UIHosting controller converting SWIFTUI View into UIKit View
                        hostingController = UIHostingController(rootView: keyboardContent)
                        hostingController?.view.frame = .init(
                            origin: .zero,
                            size: hostingController?.view.intrinsicContentSize ?? .zero)
                        //Settings TF's Input view as our SWIFTUI View
                        textField.inputView = hostingController?.view
                    } else {
                        //Updating Hosting Content
                        hostingController?.rootView = keyboardContent
                    }
                } else {
                    print("Failed to Finf TF")
                }
            }
        }
    }
}



// Extracting TextField From the Subviews
fileprivate extension UIView {
    var allSubViews: [UIView] {
        return subviews.flatMap { [$0] + $0.subviews }
    }
    
    var findtextField: UITextField? {
        if let textField = allSubViews.first(where: { view in
            view is UITextField
        }) as? UITextField {
            return textField
        }
        
        return nil
    }
}
