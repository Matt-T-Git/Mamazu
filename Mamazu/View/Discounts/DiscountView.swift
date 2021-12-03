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
        ScrollView {
            Text("Discoun View For Mamazu")
        }
        .frame(maxWidth: size.width, maxHeight: .infinity)
        .background(Color.mamazuBackground)
        .ignoresSafeArea()
    }
}

struct DiscountView_Previews: PreviewProvider {
    static var previews: some View {
        DiscountView()
    }
}
