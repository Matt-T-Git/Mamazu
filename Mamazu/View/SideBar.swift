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
                        Image("HomeIcon").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                        Text("Mamazu").foregroundColor(.mamazuTextColor).fontWeight(.bold)
                    }
                }
                NavigationLink(destination: AddMamazuView()) {
                    HStack{
                        Image("LocationIcon").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                        Text(LocalizedString.add).foregroundColor(.mamazuTextColor).fontWeight(.bold)
                    }
                }
                NavigationLink(destination: ProfileView()) {
                    HStack{
                        Image("ProfileIcon").renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                        Text(LocalizedString.profile).foregroundColor(.mamazuTextColor).fontWeight(.bold)
                    }
                }
            }
            .accentColor(.mamazuCardBackground)
            .background(Color.mamazuBackground)
            .listStyle(SidebarListStyle())
            .navigationTitle("Mamazu")
            
            HomeView()
        }
    }
}

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar()
    }
}
