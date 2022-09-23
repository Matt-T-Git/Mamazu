//
//  SideBar.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 3.04.2021.
//

import SwiftUI

struct SideBar: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: HomeView()) {
                    HStack{
                        Image("TabBar-Home").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                        Text("Mamazu").foregroundColor(.mamazuTextColor).fontWeight(.bold)
                    }
                }
                NavigationLink(destination: AddMamazuView()) {
                    HStack{
                        Image("TabBar-Add").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                        Text(LocalizedString.add).foregroundColor(.mamazuTextColor).fontWeight(.bold)
                    }
                }
//                NavigationLink(destination: DiscountView()) {
//                    HStack{
//                        Image("TabBar-Discount").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
//                        Text(LocalizedString.discount).foregroundColor(.mamazuTextColor).fontWeight(.bold)
//                    }
//                }
                NavigationLink(destination: ProfileView()) {
                    HStack{
                        Image("TabBar-Profile").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                        Text(LocalizedString.profile).foregroundColor(.mamazuTextColor).fontWeight(.bold)
                    }
                }
            }
            .accentColor(.mamazuCardBackground)
            .background(Color.mamazuBackground)
            .listStyle(.sidebar)
            .navigationTitle("Mamazu")
            
            HomeView()
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar()
    }
}
