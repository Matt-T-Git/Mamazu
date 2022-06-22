//
//  ProfileView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 9.03.2021.
//

import SwiftUI
import SDWebImageSwiftUI
import WeatherKit

struct ProfileHeaderView: View {
    
    @StateObject var userViewModel = UserViewModel()
    @StateObject var locationManager: LocationManager = LocationManager()
    @AppStorage("city") var city: String = "-"
    
    @State private var weather: Weather?
    private let weatherService = WeatherService.shared
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .background(LinearGradient(gradient: Gradient(colors: [.mamazuPurple, .mamazuDarkPink, .mamazuYellow]),
                                           startPoint: .leading, endPoint: .trailing))
                .mask(Capsule())
                .foregroundColor(.clear)
            ZStack {
                Capsule()
                    .frame(height: 72)
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
                        
                    VStack(alignment: .leading, spacing: 0) {
                        Text(LocalizedString.welcome).font(.system(size: 12, weight: .regular)).foregroundColor(.mamazuTextColor)
                        Text(userViewModel.userName)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color.mamazuTextColor)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Text(city).font(.system(size: 10, weight: .medium)).foregroundColor(.mamazuTextCaption).lineLimit(1).minimumScaleFactor(0.5)
                    }
                    Spacer()
                    VStack(spacing: 3) {
                        Image(systemName: weather?.currentWeather.symbolName ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 30, maxHeight: 30)
                            .foregroundColor(Color.mamazuLoginGradientDark).opacity(0.8)
                        Text(weather?.currentWeather.temperature.formatted() ?? "")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.mamazuTextColor)
                        
                    }
                }
                .padding(.horizontal, 10)
                .padding(.trailing, 15)
            }
        }
        .task(id: locationManager.lastLocation, {
            do {
                if let location = locationManager.lastLocation {
                    try await weather = weatherService.weather(for: location)
                }
            } catch {
                print(error)
            }
        })
        .frame(maxWidth: size.width)
        .frame(height: 75)
        .onAppear(perform: {
            userViewModel.getCombineUserInfo()
        })
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(city: "Antalya")
    }
}
