//
//  MamazuCard.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 16.03.2021.
//

import UIKit
import SwiftUI
import SDWebImageSwiftUI

struct MamazuCard: View {
    
    @StateObject var mamazuViewModel = MamazuViewModel()
    var mamazuData: MamazuResults
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 45, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .background(LinearGradient(gradient: Gradient(colors: [.mamazuCardGradientLeft, .mamazuCardGradientRight]),
                                           startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.clear)
                .cornerRadius(45, style: .continuous)
                .height(470)
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 45, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.mamazuCardBackground)
                    .shadow(color: Color.mamazuCardShadow, radius: 10, x: 0, y: 5)
                    .padding(.top, 6)
                    .height(470)
                VStack(alignment: .leading) {
                    AnimatedImage(url: URL(string: mamazuImgUrl(mamazuData.image))).indicator(SDWebImageActivityIndicator.large)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .layoutPriority(-1)
                        .frame(maxWidth: UIDevice.current.iPad ? size.width / 2 - 40 : size.width - 60, maxHeight: 390)
                        .cornerRadius(40, style: .continuous)
                        .padding(.top,4)
                    HStack(alignment: .center, spacing: 12) {
                        AnimatedImage(url: URL(string: mamazuData.user.profileImg)).indicator(SDWebImageActivityIndicator.medium)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 45)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(18, style: .continuous)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(mamazuData.user.name).font(.system(size: 15, weight: .bold)).foregroundColor(Color.mamazuTextColor)
                            Text(timeAgoFrom(mamazuData.date)).font(.system(size: 12, weight: .regular)).foregroundColor(Color.mamazuTextCaption)
                        }
                        .padding(.top, 4)
                    }
                    .padding(.leading, 15)
                }
                .layoutPriority(1)
                .padding(10)
            }
        }
        .frame(maxWidth: UIDevice.current.iPad ? size.width / 2 - 20 : size.width - 60)
        .padding(.horizontal, 20)
        .height(470)
    }
}

struct MamazuCard_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserModel(id: "5edf2cfb1800575cd00e9109",
                             name: "Sercan Burak AĞIR",
                             email: "sercanburak@gmail.com",
                             profileImg: "https://www.mamazuapp.com/profileImages/40e6d246-6101-4b9a-b7a6-39d66b5273df.png")
        
        let location = Location(type: "Point",
                                coordinates: [36.85789856768421, 30.76025889471372])
        
        let mamazu = MamazuResults(id: "5edf2cfb1800575cd00e9109",
                                   title: "A216 ve arkadaşları",
                                   description: "Fener park girişinde 3 - 4 arkadaş geziyorlar. Havalar artık ısınmaya başladı mamanın yanında su da çok önemli",
                                   image: "https://www.mamazuapp.com/mamazuImages/d81cb359-6303-4237-93b7-621675771f96.jpeg",
                                   date: "2020-06-09T05:59:51.301Z",
                                   user: user, location: location)
        
        MamazuCard(mamazuData: mamazu)
            .preferredColorScheme(.light)
    }
}
