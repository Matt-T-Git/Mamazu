//
//  MamazuDetail.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 19.03.2021.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct MamazuDetail: View {
    var size = UIScreen.main.bounds
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @StateObject var locationManager = LocationManager()
    
    var mamazuData: MamazuResults
    @Binding var isShow: Bool
    @State var isMapdetailShow: Bool = false
    
    @State var distanceMetric: String = ""
    @State var distance: String = ""
    
    @State var walkDistanceMectic: String = ""
    @State var walkDistance: String = ""
    
    @State var carDistanceMectic: String = ""
    @State var carDistance: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                //MARK:- Top Card View
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                        Rectangle()
                            .fill(Color.mamazuCardBackground)
                            .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 45))
                            .shadow(color: Color.mamazuCardShadow, radius: 10, x: 0, y: 10)
                        HStack {
                            AnimatedImage(url: URL(string: mamazuData.user.profileImg)).indicator(SDWebImageActivityIndicator.medium)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .cornerRadius(18)
                            VStack(alignment: .leading, spacing: 2){
                                Text(mamazuData.user.name).font(.system(size: 15, weight: .bold)).foregroundColor(Color.mamazuTextColor)
                                Text(timeAgoFrom(mamazuData.date)).font(.system(size: 12, weight: .regular)).foregroundColor(Color.mamazuTextCaption)
                            }
                        }
                        .padding(.bottom, 10)
                        .padding(.leading, 25)
                    }
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.mamazuCardGradientLeft, .mamazuCardGradientRight]),
                                             startPoint: .leading, endPoint: .trailing))
                        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 45))
                        .frame(height: size.height / 2 + 4)

                    AnimatedImage(url: URL(string: mamazuData.image)).indicator(SDWebImageActivityIndicator.medium)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: size.width)
                        .frame(height: size.height / 2)
                        .background(Color.mamazuCardBackground)
                        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 50))
                }
                .overlay(
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("Close")
                    })
                    .padding(.trailing, 20)
                    .padding(.top, safeAreaInsets.top)
                    ,alignment: .topTrailing
                )
                .frame(maxWidth: size.width)
                .frame(height: size.height / 2 + 83)

                
                //MARK:- Detail
                VStack {
                    
                    //MARK:- Title
                    GradientText(text: mamazuData.title, colors: [.mamazuCardGradientLeft, .mamazuCardGradientRight],
                                 font: .system(size: 24, weight: .bold, design: .rounded))
                        .frame(maxWidth: size.width, maxHeight: 28, alignment: .leading)
                    
                    Divider().padding(.top, 10)
                    
                    //MARK:- Description Text
                    Text(mamazuData.description).font(.system(size: 15, weight: .regular)).foregroundColor(Color.mamazuTextCaption)
                        .lineSpacing(3)
                        .frame(maxWidth: size.width - 45, alignment: .leading)
                    
                    Divider().padding(.top, 10)
                    
                    //MARK:- MapView
                    MamazuMapView(latitude: mamazuData.location.coordinates[1], longitude: mamazuData.location.coordinates[0], title: mamazuData.title)
                        
                        .frame(maxWidth: size.width)
                        .frame(height: 150)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.mamazuLostCardGradientLeft, lineWidth: 1)
                        )
                        .onTapGesture {
                            self.isMapdetailShow.toggle()
                        }
                        .sheet(isPresented: $isMapdetailShow, content: {
                            DetailedMapView(latitude: mamazuData.location.coordinates[1],
                                            longitude: mamazuData.location.coordinates[0],
                                            title: mamazuData.title)
                                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        })
                        .padding(.vertical, 10)
                    
                    Divider().padding(.top, 10)
                    //MARK:- DistanceBoxes
                    HStack(alignment: .top) {
                        MapDistanceBoxView(image: "location.fill", value: distance, meter: distanceMetric,
                                           colors: [.LightBoxLeft, .LightBoxRight])
                        Spacer()
                        MapDistanceBoxView(image: "figure.walk", value: walkDistance, meter: walkDistanceMectic,
                                           colors: [.MidBoxLeft, .MidBoxRight])
                        Spacer()
                        MapDistanceBoxView(image: "car.fill", value: carDistance, meter: carDistanceMectic,
                                           colors: [.DarkBoxLeft, .DarkBoxRight])
                    }
                    .padding(.top, 15)
                }
                .frame(maxWidth: size.width)
                .padding(.horizontal, 25)
                .padding(.top, 15)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mamazuBackground)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .onAppear(perform: {
            calculateDistance()
        })
    }
    
    fileprivate func calculateDistance() {
        
        let latitude = self.mamazuData.location.coordinates[1]
        let longitude = self.mamazuData.location.coordinates[0]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            guard let userLatitude = self.locationManager.lastLocation?.coordinate.latitude,
                  let userLongitude = self.locationManager.lastLocation?.coordinate.longitude else { return }

            let destinationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinate)
            let destinationMapItem = MKMapItem(placemark: destinationPlaceMark)
            
            let mapCoordinate = CLLocation(latitude: latitude, longitude:longitude)
            let userCoordinate = CLLocation(latitude: userLatitude, longitude: userLongitude)
            let distanceInMeters = mapCoordinate.distance(from: userCoordinate)
            
            let request = MKDirections.Request()
            request.source = .forCurrentLocation()
            request.destination = destinationMapItem
            request.transportType = .walking
            request.requestsAlternateRoutes = false
            let direction = MKDirections(request: request)
            
            let carRequest = MKDirections.Request()
            carRequest.source = .forCurrentLocation()
            carRequest.destination = destinationMapItem
            carRequest.transportType = .automobile
            carRequest.requestsAlternateRoutes = false
            let carDirection = MKDirections(request: carRequest)
            
            DispatchQueue.main.async {
                direction.calculate { (response, error) in
                    if let route = response?.routes.first {
                        let formattedTime = route.expectedTravelTime.formattedTime
                        withAnimation {
                            self.walkDistance = formattedTime
                            self.walkDistanceMectic = formattedTime.hasPrefix("0") ? LocalizedString.minute : LocalizedString.hour
                        }
                        
                    }
                }
                
                carDirection.calculate {  (response, error) in
                    if let route = response?.routes.first {
                        let formattedTime = route.expectedTravelTime.formattedTime
                        withAnimation {
                            self.carDistance = formattedTime
                            self.carDistanceMectic = formattedTime.hasPrefix("0") ? LocalizedString.minute : LocalizedString.hour
                        }
                    }
                }
                withAnimation {
                    let dist: String = distanceInMeters < 1000 ? "%.3f" : "%.1f"
                    self.distanceMetric = distanceInMeters < 1000 ? LocalizedString.meter : LocalizedString.kilometer
                    self.distance = String(format: dist, distanceInMeters / 1000)
                }
            }
        }
    }
}

struct MamazuDetail_Previews: PreviewProvider {
    static var previews: some View {
        
        let user = UserModel(id: "5",
                             name: "Sercan Burak AĞIR",
                             email: "sercanburak@gmail.com",
                             profileImg: "https://www.mamazuapp.com/profileImages/40e6d246-6101-4b9a-b7a6-39d66b5273df.png")
        
        let location = Location(type: "Point",
                                coordinates: [32.85789856768421, 30.76025889471372])
        
        let mamazu = MamazuResults(id: "5ed",
                                   title: "A216 ve arkadaşları",
                                   description: "Fener park girişinde 3 - 4 arkadaş geziyorlar. Havalar artık ısınmaya başladı mamanın yanında su da çok önemli",
                                   image: "https://www.mamazuapp.com/mamazuImages/d81cb359-6303-4237-93b7-621675771f96.jpeg",
                                   date: "2020-06-09T05:59:51.301Z",
                                   user: user, location: location)
        
        Group {
            MamazuDetail(mamazuData: mamazu, isShow: .constant(true))
                .preferredColorScheme(.dark)
        }
    }
}
