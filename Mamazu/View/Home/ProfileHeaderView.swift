//
//  ProfileView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 9.03.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileHeaderView: View {
    
    @StateObject var userViewModel = UserViewModel()
    @StateObject var locationManager: LocationManager = LocationManager()
    @AppStorage("city") var city: String = "-"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .background(LinearGradient(gradient: Gradient(colors: [.mamazuPurple, .mamazuDarkPink, .mamazuYellow]),
                                           startPoint: .leading, endPoint: .trailing))
                .mask(Capsule())
                .foregroundColor(.clear)
            ZStack {
                Capsule()
                    .height(70)
                    .foregroundColor(.mamazuCardBackground)
                    .shadow(color: Color.mamazuCardShadow, radius: 10, x: 0, y: 5)
                HStack(spacing: 15){
                    AnimatedImage(url: URL(string: userViewModel.imageUrl)).indicator(SDWebImageActivityIndicator.gray)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .background(.mamazuBackground)
                        .frame(maxWidth: 55, maxHeight: 55)
                        .cornerRadius(27)
                        .border(Color.mamazuCardGradientLeft, width: userViewModel.isFetched ? 1 : 0, cornerRadius: 27)
                    VStack(alignment: .leading) {
                        Text(LocalizedString.welcome).font(.system(size: 13, weight: .regular)).foregroundColor(.mamazuTextColor)
                        Text(userViewModel.userName).font(.system(size: 16, weight: .bold)).foregroundColor(Color.mamazuTextColor).lineLimit(1).minimumScaleFactor(0.5)
                        Text(city).font(.system(size: 12, weight: .medium)).foregroundColor(.mamazuTextCaption).lineLimit(1).minimumScaleFactor(0.5)
                        
                    }
                    Spacer()
                    Image("ProfileHeaderLogo")
                        .resizable()
                        .frame(maxWidth: 44, maxHeight: 45)
                }
                .padding(.horizontal, 10)
                .padding(.trailing, 5)
            }
        }
        .frame(maxWidth: size.width)
        .height(75)
        .onAppear(perform: {
            userViewModel.getUserInfo()
        })
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(city: "Antalya")
    }
}
