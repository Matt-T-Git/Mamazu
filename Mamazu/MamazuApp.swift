//
//  MamazuApp.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 22.02.2021.
//

import SwiftUI

@main
struct MamazuApp: App {
    
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    
    var body: some Scene {
        WindowGroup {
            if !isLoggedIn() {
                OnboardingView()
            }else{
                if UIDevice.current.iPad {
                    SideBar()
                        .accentColor(.mamazuTextColor)
                } else {
                    ZStack{
                        Group {
                            switch selectedTab {
                            case .home:
                                HomeView()
                            case .add:
                                AddMamazuView()
                            case .discount:
                                DiscountView()
                            case .profile:
                                ProfileView()
                            }
                        }
                        MamazuTabBar()
                    }
                    .safeAreaInset(edge: .bottom) {
                        VStack {}.frame(height: 44)
                    }
                    
                    }
                    //MamazuTabBar()
                    //MamazuTabView()
                }
            }
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }

