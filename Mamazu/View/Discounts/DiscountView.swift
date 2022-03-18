//
//  DiscountView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 27.11.2021.
//

import SwiftUI

struct DiscountView: View {
    
    private var size = UIScreen.main.bounds
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                DiscountHeaderView()
            }
            .frame(maxWidth: size.width, maxHeight: .infinity)
            .background(Color.mamazuBackground)
            .padding(.top, proxy.safeAreaInsets.top)
            .ignoresSafeArea()
        }
    }
}

struct DiscountView_Previews: PreviewProvider {
    static var previews: some View {
        DiscountView()
    }
}
