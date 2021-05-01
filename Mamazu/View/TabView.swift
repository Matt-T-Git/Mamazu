//
//  TabView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 19.03.2021.
//

import SwiftUI

struct MamazuTabView: View {
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image("HomeIcon").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                }
            
            AddMamazuView()
                .tabItem {
                    Image("LocationIcon").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                }
            
            ProfileView()
                .tabItem {
                    Image("ProfileIcon").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                }
        }
        .accentColor(Color.mamazuTabItem)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        MamazuTabView()
    }
}

extension UITabBarController {
    open override func viewWillLayoutSubviews() {
        //Apperance
        self.tabBar.barTintColor = Color.mamazuCardBackground.toUIColor()
        self.tabBar.unselectedItemTintColor = Color.mamazuTabItem.opacity(0.4).toUIColor()
        self.tabBar.isTranslucent = false
        //Image top padding
        let array = self.viewControllers
        for controller in array! {
            controller.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -5, right: 0)
        }
    }
}
