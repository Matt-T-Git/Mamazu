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
                    .frame(height: 70)
                    .foregroundColor(Color.mamazuCardBackground)
                    .shadow(color: Color.mamazuCardShadow, radius: 10, x: 0, y: 5)
                HStack(spacing: 17){
                    ZStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .font(.system(size: 60))
                            .angularGradientGlow(colors: [Color(#colorLiteral(red: 0, green: 0.4366608262, blue: 1, alpha: 1)),
                                                          Color(#colorLiteral(red: 0, green: 0.9882656932, blue: 0.6276883483, alpha: 1)),
                                                          Color(#colorLiteral(red: 1, green: 0.9059918523, blue: 0.1592884958, alpha: 1)),
                                                          Color(#colorLiteral(red: 1, green: 0.2200134695, blue: 0.2417424321, alpha: 1))])
                            .frame(width: 50, height: 50)
                            .blur(radius: 5)
                        AnimatedImage(url: URL(string: userViewModel.imageUrl)).indicator(SDWebImageActivityIndicator.gray)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .background(Color.mamazuBackground)
                            .frame(maxWidth: 52, maxHeight: 52)
                            .cornerRadius(27)
                    }
                        
                    VStack(alignment: .leading, spacing: -2) {
                        Text(LocalizedString.welcome).font(.system(size: 12, weight: .regular)).foregroundColor(.mamazuTextColor)
                        Text(userViewModel.userName)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color.mamazuTextColor)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text(city).font(.system(size: 10, weight: .medium)).foregroundColor(.mamazuTextCaption).lineLimit(1).minimumScaleFactor(0.5)
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
        .frame(height: 75)
        .onAppear(perform: {
            userViewModel.getUserInfo()
        })
//        .task {
//            await userViewModel.getUserInfo()
//        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(city: "Antalya")
    }
}
