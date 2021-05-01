//
//  ProfileView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 9.03.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    
    @StateObject var userViewModel = UserViewModel()
    @StateObject var locationManager = LocationManager()
    @StateObject var lostViewModel = LostViewModel()
    @StateObject var mamazuViewModel = MamazuViewModel()
    private let pickerPurple = Color(hex: 0x636FF7).toUIColor()
    @State private var selectedView = 0
    
    @State var isLostDetailShow: Bool = false
    @State var isMamazuDetailShow: Bool = false
    @State var isShowingSheet: Bool = false
    @State var isLogout: Bool = false
    
    @State var selectedLostAnimal: LostAnimalResults?
    @State var selectedMamazu: MamazuResults?
    
    @State var addLostPetLocation: Bool = false
    @State var addMamazuLocation: Bool = false
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = pickerPurple
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: pickerPurple!], for: .normal)
    }
    
    var body: some View {
        let size = UIScreen.main.bounds
        
        ScrollView {
            VStack {
                //MARK:- Top Card View
                ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                    Rectangle()
                        .fill(Color.mamazuCardBackground)
                        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 45))
                        .shadow(color: Color.mamazuCardShadow, radius: 10, x: 0, y: 10)
                    AnimatedImage(url: URL(string: userViewModel.imageUrl)).indicator(SDWebImageActivityIndicator.medium)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height / 2 - 50)
                        .background(Color.mamazuCardBackground)
                        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 50))
                        .padding(.bottom, 50)
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.mamazuPurple, .mamazuLostCardGradientRight]),
                                             startPoint: .bottomLeading, endPoint: .topTrailing))
                        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 45))
                        .padding(.bottom, 50)
                        .opacity(0.85)
                    
                    AnimatedImage(url: URL(string: userViewModel.imageUrl)).indicator(SDWebImageActivityIndicator.medium)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(UIDevice.current.iPhones_5_5s_5c_SE ? 30 : 60, style: .continuous)
                        .frame(width: profileImageSize() , height: profileImageSize())
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 10)
                        .padding(.bottom, UIDevice.current.iPhones_5_5s_5c_SE ? 30 : 50)
                    Text(userViewModel.userName).font(.system(size: UIDevice.current.iPhones_5_5s_5c_SE ? 13 : 22, weight: .bold)).foregroundColor(.white)
                        .padding(.top, profileImageSize())
                    
                }
                
                .overlay(
                    Picker(selection: $selectedView, label: Text("")) {
                        Text("Mamazu").tag(0)
                        Text("Kayıp").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 45)
                    .padding(.bottom, 10)
                    ,alignment: .bottom
                )
                
                .overlay(
                    Image("Logout")
                        .onTapGesture {
                            self.isShowingSheet.toggle()
                        }
                        
                        .padding(.trailing, 20)
                        .padding(.top,UIDevice.current.iPad ? 0 : UIApplication.shared.windows.first!.safeAreaInsets.top)
                        .padding(.bottom,UIDevice.current.iPad ? 80 : 0)
                    ,alignment: UIDevice.current.iPad ? .bottomTrailing : .topTrailing
                )
                
                .height(size.height / 2)
            }
            .opacity(userViewModel.isFetched ? 1 : 0)
            .animation(.easeIn(duration: 0.5))
            .actionSheet(isPresented: $isShowingSheet) {
                ActionSheet(
                    title: Text("Mamazu"),
                    message: Text("Çıkış yapmak istediğinize emin misiniz ?"),
                    buttons: [.default(Text("Çıkış Yap"), action: {
                        UserDefaults.standard.setIsLoggedIn(value: false)
                        UserDefaults.standard.resetUserToken()
                        self.isLogout.toggle()
                    }),
                    .cancel()]
                )
            }
            .fullScreenCover(isPresented: $isLogout) {
                LoginView()
            }
            
            
                        if selectedView == 0 {
                            if mamazuViewModel.mamazu.isEmpty {
                                EmptyMamazu(closure: {
                                    self.addMamazuLocation.toggle()
                                }, title: "Hiç yardım noktası \npaylaşmamışsınız!!!"
                                )
                                .sheet(isPresented: $addMamazuLocation, onDismiss: { mamazuViewModel.fetchCurrentUsersMamazuLocations() }) { AddMamazuLocationView() }
                                .padding(.top, 50)
                                .opacity(userViewModel.isFetched ? 1 : 0)
                                .animation(.easeIn(duration: 0.5))
                            }else {
                                ScrollView {
                                    LazyVGrid(columns: [GridItem(.adaptive(size.height / 3)),
                                                        GridItem(.adaptive(size.height / 3)),
                                                        GridItem(.adaptive(size.height / 3))],
                                              alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
                                                ForEach(self.mamazuViewModel.mamazu) { mamazu in
                                                    AnimatedImage(url: URL(string: mamazu.image)).indicator(SDWebImageActivityIndicator.medium)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .cornerRadius(20)
                                                        .frame(height: size.width / 3 - 20)
                                                        .onTapGesture {
                                                            self.selectedMamazu = mamazu
                                                            DispatchQueue.main.async {
                                                                self.isMamazuDetailShow = true
                                                            }
                                                        }
                                                        .sheet(item: $selectedMamazu) {
                                                            MamazuDetail(mamazuData: $0, isShow: $isMamazuDetailShow)
                                                        }
                                                }
                                              })
                                }
                                .padding()
                            }
            
                        }else{
            
                            if lostViewModel.lost.isEmpty {
                                EmptyMamazu(closure: {
                                    self.addLostPetLocation.toggle()
                                }, title: "Hiç kayıp bildiriminde bulunmamışsınız."
                                )
                                .sheet(isPresented: $addLostPetLocation, onDismiss: { lostViewModel.fetchCurrentUsersLostLocations() }) { AddLostPetView() }
                                .padding(.top, 50)
                            }else {
                                ScrollView {
                                    LazyVGrid(columns: [GridItem(.adaptive(size.height / 3)),
                                                        GridItem(.adaptive(size.height / 3)),
                                                        GridItem(.adaptive(size.height / 3))],
                                              alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
                                                ForEach(self.lostViewModel.lost) { lost in
                                                    AnimatedImage(url: URL(string: lost.image)).indicator(SDWebImageActivityIndicator.medium)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .cornerRadius(20)
                                                        .frame(height: size.width / 3 - 20)
                                                        .onTapGesture {
                                                            self.selectedLostAnimal = lost
                                                            DispatchQueue.main.async {
                                                                self.isLostDetailShow = true
                                                            }
                                                        }
                                                        .sheet(item: $selectedLostAnimal) {
                                                            LostDetailView(lostData: $0, isShow: $isLostDetailShow)
                                                        }
                                                }
                                              })
                                }
                                .padding()
                            }
                        }
        }
        .onAppear(perform: {
            lostViewModel.fetchCurrentUsersLostLocations()
            mamazuViewModel.fetchCurrentUsersMamazuLocations()
            userViewModel.getUserInfo()
        })
        
        .frame(maxWidth: .infinity, maxHeight: size.height)
        .background(.mamazuBackground)
        .ignoresSafeArea()
        
    }
    
    fileprivate func profileImageSize() -> CGFloat {
        var imageSize: CGFloat
        if UIDevice.current.iPhones_5_5s_5c_SE {
            imageSize = 120
        }else if UIDevice.current.iPad {
            imageSize = size.width / 3
        }else {
            imageSize = size.width / 1.9
        }
        return imageSize
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView()
                .preferredColorScheme(.dark)
        }
    }
}