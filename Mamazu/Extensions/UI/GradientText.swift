//
//  GradientText.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 22.02.2021.
//

import Foundation
import SwiftUI

extension View {
    func GradientText(text: String, colors: [Color], font: Font) -> some View {
        Text(text).font(font)
            .foregroundColor(.clear)
            .overlay(
                LinearGradient(gradient: Gradient(colors: colors),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .mask(Text(text)
                            .font(font).scaledToFill()
                    )
            )
    }
}
