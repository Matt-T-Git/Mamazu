//
//  OnboardingView.swift
//  OnboardingView
//
//  Created by Sercan Burak AĞIR on 2.09.2021.
//

import SwiftUI
import UIKit

struct OnboardingView: View {
    
//    init() {
//        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "mamazuCardGradientRight")
//        UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "mamazuCardGradientRight")!.withAlphaComponent(0.2)
//    }
    
    var body: some View {
        TabView {
            MamazuOnboardView()
            LostOnboardView()
            LocationOnboardView()
            LoginView()
        }
        .background(Color.mamazuCardBackground)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().preferredColorScheme(.dark)
    }
}
