//
//  LostOnboardView.swift
//  LostOnboardView
//
//  Created by Sercan Burak AĞIR on 2.09.2021.
//

import SwiftUI

struct LostOnboardView: View {
    private var size = UIScreen.main.bounds
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            background
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mamazuBackground)
        .edgesIgnoringSafeArea(.all)
    }
    
    var background: some View {
        Group {
            Image("ON_Lost")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: size.width, maxHeight: size.height)
            RadialGradient(colors: [.mamazuCardBackground.opacity(0.4), .mamazuCardBackground], center: .top, startRadius: 200, endRadius: 550)
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack {
                Image("ON_CircleLogo")
                    .resizable()
                    .frame(maxWidth: 85, maxHeight: 85)
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 10)
                
                Image("ON_CircleLogo")
                    .resizable()
                    .frame(maxWidth: 80, maxHeight: 80)
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.8)
            }
            .padding(.bottom, 20)
            GradientText(text: LocalizedString.Onboarding.lostTitle,
                         colors: [Color.mamazuCardGradientLeft, Color.mamazuCardGradientRight],
                         font: .system(size: 30, weight: .bold))
            Text(LocalizedString.Onboarding.lostSubtitle)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.mamazuTitle)
        }
        .padding(.bottom, size.height / 7)
        .padding(.horizontal, 20)
    }
}

struct LostOnboardView_Previews: PreviewProvider {
    static var previews: some View {
        LostOnboardView()
            .preferredColorScheme(.dark)
    }
}


