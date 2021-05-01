//
//  LoadingView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 1.03.2021.
//

import SwiftUI
import SwiftUIX

struct LoadingView: View {
    @Binding var isShowing: Bool
    var animationName: String = ""
    
    var body: some View {
        let size = UIScreen.main.bounds
        
        if isShowing{
            ZStack {
                VisualEffectBlurView(blurStyle: .regular)
                    .cornerRadius(35, style: .continuous)
                    .frame(width: size.width / 1.8, height: size.width / 1.8)
                    .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 10)
                VStack {
                    LottieView(name: animationName)
                        .frame(width: 180, height: 180)
                    Text("Yükleniyor...")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color.mamazuTextColor)
                        .padding(.bottom, UIDevice.current.iPhones_5_5s_5c_SE ? 55 : 15)
                }
            }
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
        }
    }
}

