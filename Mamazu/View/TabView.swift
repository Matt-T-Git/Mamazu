//
//  TabView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 19.03.2021.
//

import SwiftUI
import UIKit

struct MamazuTabView: View {
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image("TabBar-Home").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                }
            
            AddMamazuView()
                .tabItem {
                    Image("TabBar-Add").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                }
            
            DiscountView()
                .tabItem {
                    Image("TabBar-Discount").renderingMode(.template)
                }
            
            ProfileView()
                .tabItem {
                    Image("TabBar-Profile").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                }
        }
        .background(Color.mamazuCardBackground)
        .accentColor(Color.mamazuTabItem)
        .ignoresSafeArea()
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
        self.tabBar.barTintColor = UIColor(named: "CardBG")
        self.tabBar.unselectedItemTintColor = UIColor(named: "TabItemColor")?.withAlphaComponent(0.4)
        self.tabBar.isTranslucent = false
        //Icon top padding
        let array = self.viewControllers
        for controller in array! {
            controller.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -5, right: 0)
        }
    }
}
