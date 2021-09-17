//
//  Swiftui+View.swift
//  Swiftui+View
//
//  Created by Sercan Burak AĞIR on 1.09.2021.
//

import SwiftUI

extension View {
    func angularGradientGlow(colors: [Color]) -> some View {
        self.overlay(AngularGradient(colors: colors, center: .center, angle: .degrees(0.0)))
            .mask(self)
    }
}
