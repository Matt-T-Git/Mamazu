//
//  MamazuApp.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 22.02.2021.
//

import SwiftUI

@main
struct MamazuApp: App {
    
    @State var selectedTab: Tab = .home
    
    var body: some Scene {
        WindowGroup {
            if !isLoggedIn() {
                OnboardingView()
            }else{
                if UIDevice.current.iPad {
                    SideBar()
                        .accentColor(.mamazuTextColor)
                } else {
                    MamazuTab(selectedTab: $selectedTab)
                }
            }
        }
    }
}

fileprivate func isLoggedIn() -> Bool {
    return UserDefaults.standard.isLoggedIn()
}

