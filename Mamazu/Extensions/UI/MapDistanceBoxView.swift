//
//  MapDistanceBoxView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 21.03.2021.
//

import SwiftUI

var size = UIScreen.main.bounds

func MapDistanceBoxView(image: String, value: String, meter: String, colors: [Color]) -> some View {
    ZStack {
        LinearGradient(gradient: Gradient(colors: colors),
                       startPoint: .bottomLeading, endPoint: .topTrailing)
            .cornerRadius(25)
            .shadow(color: colors[0].opacity(0.3), radius: 5, x: 0, y: 5)
        VStack (alignment: .center, spacing: 0){
            Image(systemName: image).font(.system(size: 26)).foregroundColor(.white)
            Text(value).font(.system(size: 25, weight: .bold, design: .rounded)).foregroundColor(.white)
            Text(meter).font(.system(size: 13, weight: .medium, design: .rounded)).foregroundColor(.white)
        }
    }
    .frame(maxWidth: size.width / 3 - 30, maxHeight: 200)
    .frame(height: size.width / 3  - 30)
    .padding(.bottom, 40)
}
