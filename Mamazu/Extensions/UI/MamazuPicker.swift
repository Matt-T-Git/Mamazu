//
//  MamazuPicker.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 24.03.2021.
//

import SwiftUI
import UIKit

struct MamazuPicker: View {
    
    @Binding var selectedText: String
    
    var placeholder: String
    var borderColor: Color
    var list: [String]
    
    var height: CGFloat? = 48
    var radius: CGFloat? = 15
    
    var image: String
    
    @State var selectionIndex = 0
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.mamazuTextFieldPlaceholderBg)
                Image(systemName: image)
                    .foregroundColor(Color("Placeholder"))
            }
            .frame(width: 35, height: 35)
            .padding(.leading, 8)
            TextFieldWithInputView(data: list,
                                   placeholder: placeholder,
                                   selectionIndex: $selectionIndex,
                                   selectedText: $selectedText)
                
                .frame(height: height)
                .textFieldStyle(PlainTextFieldStyle())
                .padding([.trailing, .leading], 5)
                .foregroundColor(Color.mamazuTextColor)
        }
        .background(Color.mamazuTextFieldColor)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
        .cornerRadius(radius!)
        .overlay(
            RoundedRectangle(cornerRadius: radius!, style: .continuous)
                .stroke(borderColor, lineWidth: 1)
        )
    }
}
