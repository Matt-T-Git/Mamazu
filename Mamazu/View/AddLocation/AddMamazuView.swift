//
//  AddMamazuView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 9.03.2021.
//

import SwiftUI

struct AddMamazuView: View {
    let size = UIScreen.main.bounds
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @State var showMamazuLocation: Bool = false
    @State var showLostLocation: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            ScrollView {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 15, content: {
                    Image("LogoPurple")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 185, maxHeight: 150)
                    Spacer()
                    LocationCardView(image: "AddMamazuBackground", title: LocalizedString.AddLocation.addHelpLocation,
                                     gradient: [.mamazuCardGradientLeft, .mamazuCardGradientRight])
                        .onTapGesture {
                            showMamazuLocation.toggle()
                        }
                        .sheet(isPresented: $showMamazuLocation, content: {
                            AddMamazuLocationView()
                        })
                    
                    Spacer()
                    LocationCardView(image: "AddLostLocationBackground", title: LocalizedString.AddLocation.addMissingListing,
                                     gradient: [.mamazuLostCardGradientLeft, .mamazuLostCardGradientLeft])
                        .onTapGesture {
                            showLostLocation.toggle()
                        }
                        .sheet(isPresented: $showLostLocation, content: {
                            //SizeView()
                            AddLostPetView()
                        })

                    
                })
                .frame(maxWidth: size.width, maxHeight: size.height)
                .padding(.top, safeAreaInsets.top + 10)
            }
            .background(
                Image("Onb_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: size.width, maxHeight: size.height)
                    .opacity(0.5)
                    .rotationEffect(Angle(degrees: 180), anchor: .center)
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mamazuBackground)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct AddMamazuView_Previews: PreviewProvider {
    static var previews: some View {
        AddMamazuView()
    }
}
