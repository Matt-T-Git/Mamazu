//
//  DiscountHeaderView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 29.11.2021.
//

import SwiftUI

struct DiscountHeaderView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .frame(height: 74)
                .background(
                    LinearGradient(colors: [Color.red, Color.blue], startPoint: .leading, endPoint: .trailing)
                )
                .mask(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .foregroundColor(.clear)
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .frame(height: 70)
                .foregroundColor(.mamazuCardBackground)
                .shadow(color: Color.mamazuCardShadow, radius: 10, x: 0, y: 5)
            
        }
        .padding(.horizontal, 20)
    }
}

struct DiscountHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DiscountHeaderView()
    }
}
