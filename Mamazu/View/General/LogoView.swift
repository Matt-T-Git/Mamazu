//
//  LogoView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 24.02.2021.
//

import SwiftUI

struct LogoView: View {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var padding: Edge.Set = .all
    var paddingSize: CGFloat = 0.0
    
    var body: some View {
        Image("LogoL")
            .resizable()
            .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .aspectRatio(contentMode: .fill)
            .padding(padding, paddingSize)
            .shadow(color: Color(hex: 0x332CAE, alpha: 0.4), radius: 8, x: 0, y: 5)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView(width: 200, height: 175, padding: .bottom, paddingSize: 40)
    }
}
