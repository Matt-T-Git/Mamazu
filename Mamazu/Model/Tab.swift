//
//  Tab.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 2.12.2021.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var color: Color
    var selection: Tab
}

var tabItems: [TabItem] = [
    TabItem(text: "Mamazu", icon: "TabBar-Home", color: Color.mamazuPurple , selection: .home),
    TabItem(text: "Ekle", icon: "TabBar-Add", color: Color.mamazuDarkPink , selection: .add),
    TabItem(text: "İndirimler", icon: "TabBar-Discount", color: Color.mamazuDiscount , selection: .discount),
    TabItem(text: "Profil", icon: "TabBar-Profile" , color: Color.mamazuJava, selection: .profile)
]

enum Tab: String {
    case home
    case add
    case discount
    case profile
}
