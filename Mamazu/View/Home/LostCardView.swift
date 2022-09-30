//
//  LostCardView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 16.03.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct LostCardView: View {
    @StateObject var lostViewModel = LostViewModel()
    var lostAnimalData: LostAnimalResults
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ContainerRelativeShape()
                .background(LinearGradient(gradient: Gradient(colors: [.mamazuLostCardGradientLeft, .mamazuLostCardGradientRight]),
                                           startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.clear)
            ZStack(alignment: .top) {
                ContainerRelativeShape()
                    .frame(height: 230)
                    .foregroundColor(Color.mamazuCardBackground)
                    .shadow(color: Color.mamazuCardShadow.opacity(1), radius: 10, x: 0, y: 5)
                VStack(alignment: .center) {
                    //Image("profile")
                    AnimatedImage(url: URL(string: lostAnimalData.image)).indicator(SDWebImageActivityIndicator.medium)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 150)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(ContainerRelativeShape())
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(lostAnimalData.petName).font(.system(size: 13, weight: .heavy, design: .rounded))
                            .foregroundColor(.mamazuTextColor)
                        Text(lostAnimalData.description).font(.system(size: 11, weight: .medium, design: .rounded))
                            .foregroundColor(.mamazuTextCaption)
                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    }
                    .frame(width: 160, alignment: .leading)
                }
                .padding(10)
            }
        }
        .containerShape(RoundedRectangle(cornerRadius: 25, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        .frame(maxWidth: 180)
        .frame(height: 233)
        .padding(.horizontal, 15)
    }
}

struct LostCardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            
    }
}
