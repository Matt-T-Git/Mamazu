//
//  LocationOnboardView.swift
//  LocationOnboardView
//
//  Created by Sercan Burak AĞIR on 2.09.2021.
//

import SwiftUI

struct LocationOnboardView: View {
    
    private var size = UIScreen.main.bounds
    @StateObject var locationManager: LocationManager = LocationManager()
    
    var body: some View {
        ZStack(alignment: .center) {
            background
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mamazuBackground)
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        VStack(alignment: .center, spacing: 5) {
            Image("ON_Icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: size.height / 2.8)
                .padding(.bottom, 50)
            
            GradientText(text: LocalizedString.Onboarding.locationTitle,
                         colors: [Color.mamazuCardGradientLeft, Color.mamazuCardGradientRight],
                         font: .system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
            Text(LocalizedString.Onboarding.locationSubtitle)
                .font(.system(size: 17, weight: .medium))
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
                .foregroundColor(.mamazuTitle)
            
            Text(locationManager.isLocated ? LocalizedString.Onboarding.locationButtonAllowedTitle : LocalizedString.Onboarding.locationButtonNotAllowedTitle)
                .frame(maxWidth: size.width - 50)
                .frame(height: 44)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .bold))
                .background(LinearGradient(gradient: Gradient(colors: locationManager.isLocated ? [Color(hex: 0x65FDF0), Color(hex: 0x1D6FA3)] : [Color(hex: 0xe52d27), Color(hex: 0xb31217)]),
                                           startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                .animation(.easeIn, value: 0)
        }
        .padding(.horizontal, 20)
    }
    
    var background: some View {
        Group {
            Image("ON_Location")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: size.width, maxHeight: size.height)
            
            RadialGradient(colors: [.mamazuCardBackground.opacity(0.4), .mamazuCardBackground], center: .top, startRadius: 200, endRadius: 550)
        }
    }
}

struct LocationOnboardView_Previews: PreviewProvider {
    static var previews: some View {
        LocationOnboardView().preferredColorScheme(.dark)
    }
}
