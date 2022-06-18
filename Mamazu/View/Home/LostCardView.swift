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
            RoundedRectangle(cornerRadius: 35, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .background(LinearGradient(gradient: Gradient(colors: [.mamazuLostCardGradientLeft, .mamazuLostCardGradientRight]),
                                           startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.clear)
                .clipShape(RoundedRectangle(cornerRadius: 35, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 35, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .frame(height: 228)
                    .foregroundColor(Color.mamazuCardBackground)
                    .shadow(color: Color.mamazuCardShadow.opacity(1), radius: 10, x: 0, y: 5)
                VStack(alignment: .center) {
                    //Image("profile")
                    ZStack {
                        AnimatedImage(url: URL(string: lostAnimalData.image))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 160, height: 150)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(25)
                            .blur(radius: 5)
                            .scaleEffect(x: 0.95)
                            .offset(y: 3)
                            
                        AnimatedImage(url: URL(string: lostAnimalData.image)).indicator(SDWebImageActivityIndicator.medium)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 160, height: 150)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(25)
                    }
                    VStack(alignment: .leading, spacing: 0) {
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
        .frame(maxWidth: 180)
        .frame(height: 235)
        .padding(.horizontal, 15)
    }
}

struct LostCardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            
    }
}
