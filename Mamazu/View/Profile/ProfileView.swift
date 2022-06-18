//
//  ProfileView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 9.03.2021.
//
import UIKit
import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @StateObject var userViewModel = UserViewModel()
    @StateObject var locationManager = LocationManager()
    @StateObject var lostViewModel = LostViewModel()
    @StateObject var mamazuViewModel = MamazuViewModel()
    
    private let pickerPurple = UIColor(red: 0.39, green: 0.44, blue: 0.97, alpha: 1.00)
    @State private var selectedView = 0
    
    @State var isLostDetailShow: Bool = false
    @State var isMamazuDetailShow: Bool = false
    @State var isShowingSheet: Bool = false
    @State var isShowingAccountDeleteSheet: Bool = false
    @State var isLogout: Bool = false
    
    @State var selectedLostAnimal: LostAnimalResults?
    @State var selectedMamazu: MamazuResults?
    
    @State var addLostPetLocation: Bool = false
    @State var addMamazuLocation: Bool = false
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = pickerPurple
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: pickerPurple], for: .normal)
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
                        .cornerRadius(UIDevice.current.iPhones_5_5s_5c_SE ? 30 : 60)
                        .frame(width: profileImageSize() , height: profileImageSize())
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 10)
                        .padding(.bottom, UIDevice.current.iPhones_5_5s_5c_SE ? 30 : 50)
                    Text(userViewModel.userName).font(.system(size: UIDevice.current.iPhones_5_5s_5c_SE ? 13 : 22, weight: .bold)).foregroundColor(.white)
                        .padding(.top, profileImageSize())
                    
                }
                
                // MARK: - Mamazu and Lost Picker View
                .overlay(
                    Picker(selection: $selectedView, label: Text("")) {
                        Text("Mamazu").tag(0)
                        Text(LocalizedString.Profile.lost).tag(1)
                    }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 45)
                        .padding(.bottom, 10)
                    ,alignment: .bottom
                )
                
                // MARK: - Logout and delete account button
                .overlay(
                    Menu(content: {
                        Button(action: { self.isShowingSheet.toggle() }) {
                            Label("Log Out", systemImage: "arrow.down.heart.fill").font(.largeTitle)
                        }
                        Button(action: { self.isShowingAccountDeleteSheet.toggle() }) {
                            Label("Delete Your account", systemImage: "trash.fill").font(.largeTitle)
                        }
                    }, label: {
                        Image("Logout")
                    })
                        .padding(.trailing, 20)
                        .padding(.top,UIDevice.current.iPad ? 0 : safeAreaInsets.top)
                        .padding(.bottom,UIDevice.current.iPad ? 80 : 0)
                    ,alignment: UIDevice.current.iPad ? .bottomTrailing : .topTrailing)
                .frame(height: size.height / 2)
            }
            .opacity(userViewModel.isFetched ? 1 : 0)
            .animation(.easeIn(duration: 0.5), value: userViewModel.isFetched)
            .actionSheet(isPresented: $isShowingAccountDeleteSheet) {
                ActionSheet(
                    title: Text("Mamazu"),
                    message: Text(LocalizedString.Profile.areYouSureLogout),
                    buttons: [.default(Text(LocalizedString.Profile.logout), action: {
                        userViewModel.delete()
                        if !userViewModel.isUserDeleted { userIsLoggedOut() }
                    }),
                    .cancel()]
                )
            }
            .alert("Mamazu", isPresented: $isShowingSheet) {
                Button("Cancel", role: .cancel) { }
                Button("Log Out", role: .destructive) { userIsLoggedOut() }
            } message: {
                Text(LocalizedString.Profile.areYouSureLogout)
            }
            
            .fullScreenCover(isPresented: $isLogout) {
                LoginView()
            }
            if selectedView == 0 {
                if mamazuViewModel.mamazu.isEmpty {
                    EmptyMamazu(closure: {
                        self.addMamazuLocation.toggle()
                    }, title: LocalizedString.Profile.notSharedHelpPoints
                    )
                    .sheet(isPresented: $addMamazuLocation, onDismiss: { mamazuViewModel.fetchCurrentUsersMamazuLocations() }) { AddMamazuLocationView() }
                    .padding(.top, 50)
                    .opacity(userViewModel.isFetched ? 1 : 0)
                    .animation(.easeIn(duration: 0.5), value: userViewModel.isFetched)
                }else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: size.height / 3)),
                                            GridItem(.adaptive(minimum: size.height / 3)),
                                            GridItem(.adaptive(minimum: size.height / 3))],
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
                    .padding(.bottom, 90)
                }
                
            }else{
                
                if lostViewModel.lost.isEmpty {
                    EmptyMamazu(closure: {
                        self.addLostPetLocation.toggle()
                    }, title: LocalizedString.Profile.neverReportedLoss
                    )
                    .sheet(isPresented: $addLostPetLocation, onDismiss: { lostViewModel.fetchCurrentUsersLostLocations() }) { AddLostPetView() }
                    .padding(.top, 50)
                }else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: size.height / 3)),
                                            GridItem(.adaptive(minimum: size.height / 3)),
                                            GridItem(.adaptive(minimum: size.height / 3))],
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
                    .padding(.bottom, 50)
                }
            }
        }
        .onAppear(perform: {
            lostViewModel.fetchCurrentUsersLostLocations()
            mamazuViewModel.fetchCurrentUsersMamazuLocations()
            userViewModel.getCombineUserInfo()
        })
        
        .frame(maxWidth: .infinity, maxHeight: size.height)
        .background(Color.mamazuBackground)
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
    
    fileprivate func userIsLoggedOut() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        UserDefaults.standard.resetUserToken()
        self.isLogout.toggle()
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
