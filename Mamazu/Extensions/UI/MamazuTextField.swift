//
//  MamazuTextField.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 23.03.2021.
//

import SwiftUI
import UIKit

struct MamazuTextField: View {
    
    @Binding var bindingText: String
    var placeholder: String
    var borderColor: Color
    var backgroundColor: Color? = Color.mamazuTextFieldColor
    
    var height: CGFloat? = 48
    var radius: CGFloat? = 15
    
    var image: String
    
    var isPassword: Bool = false
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .font(.system(size: 15))
                    .angularGradientGlow(colors: [Color(#colorLiteral(red: 0, green: 0.4366608262, blue: 1, alpha: 1)),
                                                  Color(#colorLiteral(red: 0, green: 0.9882656932, blue: 0.6276883483, alpha: 1)),
                                                  Color(#colorLiteral(red: 1, green: 0.9059918523, blue: 0.1592884958, alpha: 1)),
                                                  Color(#colorLiteral(red: 1, green: 0.2200134695, blue: 0.2417424321, alpha: 1))])
                    //.frame(width: 50, height: 50)
                    .blur(radius: 4)
                    .opacity(0.6)
                RoundedRectangle(cornerRadius: 12, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.mamazuTextFieldPlaceholderBg)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(borderColor.opacity(0.3), lineWidth: 1)
                            .blendMode(.multiply)
                    )
                Image(systemName: image)
                    .foregroundColor(Color("Placeholder"))
            }
            .frame(width: 32, height: 32)
            .padding(.leading, 8)
            if !isPassword{
                TextField(placeholder, text: $bindingText)
                    .frame(height: height)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.trailing, .leading], 5)
                    .foregroundColor(Color.mamazuTextColor)
                    .contentShape(Rectangle())
            }else {
                SecureField(placeholder, text: $bindingText)
                    .frame(height: height)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.trailing, .leading], 5)
                    .foregroundColor(Color.mamazuTextColor)
                    .contentShape(Rectangle())
            }
        }
        .background(backgroundColor)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
        .cornerRadius(radius!, antialiased: true)
        .overlay(
            RoundedRectangle(cornerRadius: radius!, style: .continuous)
                .stroke(borderColor, lineWidth: 1)
                .blendMode(.softLight)
        )
    }
}

struct MamazuTextEditor: View {
    
    @Binding var bindingText: String
    var borderColor: Color
    var height: CGFloat? = 120
    var radius: CGFloat? = 20
    var image: String
    var placeholderText: String
    
    var body: some View {
        
        HStack(alignment: .top) {
            ZStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .font(.system(size: 15))
                    .angularGradientGlow(colors: [Color(#colorLiteral(red: 0, green: 0.4366608262, blue: 1, alpha: 1)),
                                                  Color(#colorLiteral(red: 0, green: 0.9882656932, blue: 0.6276883483, alpha: 1)),
                                                  Color(#colorLiteral(red: 1, green: 0.9059918523, blue: 0.1592884958, alpha: 1)),
                                                  Color(#colorLiteral(red: 1, green: 0.2200134695, blue: 0.2417424321, alpha: 1))])
                    //.frame(width: 50, height: 50)
                    .blur(radius: 4)
                    .opacity(0.6)
                RoundedRectangle(cornerRadius: 15, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.mamazuTextFieldPlaceholderBg)
                Image(systemName: image)
                    .foregroundColor(Color("Placeholder"))
            }
            .frame(width: 35, height: 35)
            .padding(.leading, 8)
            .padding(.top, 8)
            
            ZStack(alignment: .topLeading) {
                if bindingText.isEmpty {
                    Text(placeholderText)
                        .foregroundColor(Color(UIColor.placeholderText))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 13)
                }
                TextEditor(text: $bindingText)
                    .frame(height: height)
                    .padding([.trailing, .leading], 5)
                    .foregroundColor(Color.mamazuTextColor)
                    //.preferredColorScheme(.dark)
            }
        }
        .onAppear(perform: {
            UITextView.appearance().backgroundColor = .clear
            
        })
        .background(Color.mamazuTextFieldColor)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
        .cornerRadius(radius!)
        .overlay(
            RoundedRectangle(cornerRadius: radius!, style: .continuous)
                .stroke(borderColor.opacity(0.3), lineWidth: 1)
        )
    }
}


struct MamazuTextField_Previews: PreviewProvider {
    static var previews: some View {
        MamazuTextField(bindingText: .constant(""), placeholder: "Placeholder", borderColor: .mamazuLostCardGradientRight, image: "location.fill")
    }
}
