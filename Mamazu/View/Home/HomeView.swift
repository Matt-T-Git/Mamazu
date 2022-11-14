//
//  HomeView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 27.02.2021.
//

import SwiftUI

struct HomeView: View {
    
    private var size = UIScreen.main.bounds
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @StateObject var locationManager: LocationManager = LocationManager()
    @StateObject var lostViewModel = LostViewModel()
    @StateObject var mamazuViewModel = MamazuViewModel()
    
    @State var isLostDetailShow: Bool = false
    @State var isMamazuDetailShow: Bool = false
    @State var isMamazuEmpty: Bool = false
    
    @State var selectedLostAnimal: LostAnimalResults?
    @State var selectedMamazu: MamazuResults?
    
    @State var isLoading: Bool = true
    @State var isLocated: Bool = false
    @State var isPermissionError: Bool = false
    @State var errorMessage: String = ""
    
    //For scrollView Statusbar background Effect
    @State private var contentoffset: CGFloat = 0
    
    var body: some View {
        
        ZStack {
            TrackableScrollView { offset in
                contentoffset = offset.y
            } content:  {
                ZStack(alignment: .top) {
                    VStack() {
                        //MARK:- Profile Header View
                        ProfileHeaderView()
                            .padding(.top, UIDevice.current.iPad ? 80 : safeAreaInsets.top + 10)
                            .padding(.horizontal, 20)
                        
                        //MARK:- Lost Title
                        GradientText(text: LocalizedString.Home.lostTitle, colors: [.mamazuLostCardGradientLeft, .mamazuLostCardGradientRight],
                                     font: .system(size: 18, weight: .bold, design: .rounded))
                            .padding(.horizontal, 23)
                            .frame(width: size.width, height: 28, alignment: .leading)
                            .padding(.vertical, 10)
                        
                        //MARK:- Lost ScrollView
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            if lostViewModel.lost.isEmpty {
                                VStack {
                                    LottieView(name: "warning")
                                        .frame(width: size.width, height: 120)
                                    Text(LocalizedString.Home.noMissingReports)
                                        .font(.caption)
                                        .foregroundColor(.mamazuTextColor)
                                        .padding(.top, -10)
                                }
                            }else {
                                HStack(alignment: .bottom, spacing: 0) {
                                    ForEach(self.lostViewModel.lost) { lost in
                                        GeometryReader { geometry in
                                            LostCardView(lostAnimalData: lost)
                                                .padding(.top, -20)
                                                .padding(.horizontal, 10)
                                                .frame(height: 275)
                                                .rotation3DEffect(.degrees((Double(geometry.frame(in: .global).minX - 10) / -30)), axis: (x: 0, y: 10, z: 0))
                                                //.animation(.easeInOut)
                                                .onTapGesture {
                                                    self.selectedLostAnimal = lost
                                                    self.isLostDetailShow.toggle()
                                                }
                                        }
                                        .frame(width: 210, height: 280)
                                    }
                                }
                                .onAppear(perform: {
                                    if locationManager.isLocated{lostViewModel.fetchPosts()}
                                })
                                .sheet(item: $selectedLostAnimal) {
                                    LostDetailView(lostData: $0, isShow: $isLostDetailShow)
                                }
                            }
                        })
                        .padding(.top, -30)
                        .frame(height: 280)
                        .frame(maxWidth: .infinity, maxHeight: 280)
                        
                        //MARK:- Mamazu Title
                        GradientText(text: LocalizedString.Home.helpPoints, colors: [.mamazuCardGradientLeft, .mamazuCardGradientRight],
                                     font: .system(size: 18, weight: .bold, design: .rounded))
                            .padding(.horizontal, 23)
                            .frame(width: size.width, height: 28, alignment: .leading)
                            .padding(.top, -30)
                            
                        
                        //MARK:- Mamazu Card
                        if mamazuViewModel.mamazu.isEmpty {
                            VStack {
                                LottieView(name: "warning")
                                    .frame(width: size.width, height: 120)
                                Text(LocalizedString.Home.noHelpPoints)
                                    .font(.caption)
                                    .foregroundColor(.mamazuTextColor)
                                    .padding(.top, -10)
                            }
                        }else {
                            LazyVGrid(
                                columns: grid(),
                                spacing: 16
                            ) {
                                ForEach(self.mamazuViewModel.mamazu) { mamazu in
                                    MamazuCard(mamazuData: mamazu)
                                        .padding(.bottom, 25)
                                        .onTapGesture {
                                            DispatchQueue.main.async {
                                                self.selectedMamazu = mamazu
                                                self.isMamazuDetailShow.toggle()
                                            }
                                        }
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.bottom, 90)
                            .onAppear(perform: {
                                if locationManager.isLocated{mamazuViewModel.fetchPosts()}
                            })
                            .fullScreenCover(item: $selectedMamazu) {
                                MamazuDetail(mamazuData: $0, isShow: $isMamazuDetailShow)
                            }
                        }
                    }
                    .opacity(isLoading ? 0 : 1)
                    .animation(.easeIn(duration: 0.6), value: isLoading)
                    
                    //MARK:- Show Loading View
                    LoadingView(isShowing: $mamazuViewModel.isLoading, animationName: "Dog2")
                        .frame(width: size.width, height: size.height)
                        .background(Color.mamazuBackground.opacity(0.8))
                        .opacity(isLoading ? 1 : 0)
                        .animation(.easeInOut(duration: 0.5), value: isLoading)
                    
                }
                
                //MARK:- Fetch data when location service is authorised
                .onChange(of: locationManager.locationStatus, perform: { (isChanged) in
                    if isChanged  == .authorizedWhenInUse || isChanged == .authorizedAlways {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            lostViewModel.fetchPosts()
                            mamazuViewModel.fetchPosts()
                            self.isLocated = true
                        }
                    }else if isChanged == .denied || isChanged == .restricted || isChanged == .notDetermined {
                        self.isPermissionError.toggle()
                        self.errorMessage = LocalizedString.locationDisabledMessage
                    }
                })
                .alert(isPresented: $isPermissionError, content: {
                    Alert(title: Text("Mamazu"), message: Text(errorMessage),
                          primaryButton: .default(Text(LocalizedString.settings), action: {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                          }),
                          secondaryButton: .cancel()
                    )
                })
                
                .alert(isPresented: $mamazuViewModel.isError, content: {
                    Alert(title: Text("Mamazu"), message: Text(mamazuViewModel.errorMessage), dismissButton: .default(Text(LocalizedString.ok)))
                })
                
                .onChange(of: mamazuViewModel.isFetched, perform: { loading in
                    self.isLoading = !loading
                })
            }
            .overlay(alignment: .top) {
                Color.clear
                    .background(.ultraThinMaterial)
                    .opacity(contentoffset < -16 ? 0.9 : 0)
                    .animation(.easeIn, value: contentoffset)
                    .ignoresSafeArea()
                    .frame(height: safeAreaInsets.top)
            }

        }
        .frame(maxWidth: size.width, maxHeight: .infinity)
        .background(Color.mamazuBackground)
        .ignoresSafeArea()
            
    }
    
    fileprivate func grid() -> [GridItem] {
        var grid = [GridItem]()
        if UIDevice.current.userInterfaceIdiom == .pad {
            grid = [
                GridItem(.fixed(size.width / 2), spacing: 0),
                GridItem(.fixed(size.width / 2))
            ]
        }else {
            grid = [GridItem(.flexible(minimum: 40), spacing: 0)]
        }
        return grid
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
