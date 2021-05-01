//
//  UnderlineTextField.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 24.02.2021.
//

import SwiftUI

extension View {

    func RoundedTextField(placeholder: String, text: String, bindingText: Binding<String>) -> some View {
        HStack {
            Image(systemName: placeholder)
                .foregroundColor(Color("Placeholder"))
                .padding(.leading,10)
            TextField(text, text: bindingText)
                .frame(height: 48)
                .textFieldStyle(PlainTextFieldStyle())
                .padding([.trailing], 24)
                .foregroundColor(Color.mamazuTextColor)
                .preferredColorScheme(.light)
        }

        //.overlay(Rectangle().foregroundColor(lineColor).frame(height: 2), alignment: .bottom)
        .background(Color(hex: 0xF5F0FF))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
        .cornerRadius(15, style: .continuous)
    }
    
    func RoundedSecureTextField(placeholder: String, text: String, bindingText: Binding<String>) -> some View {
        HStack {
            Image(systemName: placeholder)
                .foregroundColor(Color("Placeholder"))
                .padding(.leading,10)
            SecureField(text, text: bindingText)
                .frame(height: 48)
                .textFieldStyle(PlainTextFieldStyle())
                .padding([.trailing], 24)
                .foregroundColor(Color.mamazuTextColor)
                .preferredColorScheme(.light)
        }
        .frame(height: 48)
        //.overlay(Rectangle().foregroundColor(lineColor).frame(height: 2), alignment: .bottom)
        .background(Color(hex: 0xF5F0FF))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
        .cornerRadius(15, style: .continuous)
    }
}
