//
//  MamazuApp.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 22.02.2021.
//

import SwiftUI

@main
struct MamazuApp: App {
    
    var body: some Scene {
        WindowGroup {
            if !isLoggedIn() {
                OnboardingView()
                //LoginView()
            }else{
                if UIDevice.current.iPad {
                    SideBar().accentColor(.mamazuTextColor)
                } else {
                    MamazuTabView()
                }
            }
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
}
