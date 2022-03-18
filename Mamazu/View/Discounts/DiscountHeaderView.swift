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
                .frame(height: 73)
                .background(
                    LinearGradient(colors: [Color.mamazuDiscountLeft, Color.mamazuDiscountRight], startPoint: .leading, endPoint: .trailing)
                )
                .mask(RoundedRectangle(cornerRadius: 36, style: .continuous))
                .foregroundColor(.clear)
            
            RoundedRectangle(cornerRadius: 35, style: .continuous)
                .frame(height: 70)
                .foregroundColor(.mamazuCardBackground)
                .shadow(color: Color.mamazuDiscountLeft.opacity(0.1), radius: 10, x: 0, y: 5)
            
            HStack(spacing: 10) {
                Image("discLogo")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(24)
                    .frame(width: 48)
                VStack(alignment: .leading, spacing: 2) {
                    Image("mamazuTextlogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                    Text(LocalizedString.discount)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.mamazuTitle)
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, maxHeight: 70)
            
        }
        .padding(.horizontal, 20)
    }
}

struct DiscountHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DiscountHeaderView()
    }
}
