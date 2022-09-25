//
//  ContentView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 22.02.2021.
//

import SwiftUI

struct LoginView: View {
    
    var size = UIScreen.main.bounds
    
    @State var selectedTab: Tab = .home
    @State var isRegistrationViewShow: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @StateObject private var keyboardHandler = KeyboardHandler()
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var locationManager: LocationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            ScrollView {
                    
                    //MARK:- Login Stack
                ZStack {
                    VStack(alignment: .center, spacing: 4) {
                            //MARK:- Logo View
                            ZStack {
                                Image("mmz_logo")
                                    //.fill(Color.mamazuTurquoise)
                                    .blur(radius: 45)
                                    .frame(width: 220, height: 220)
                                    .opacity(0.9)
                                VStack(spacing: -15) {
                                    Image("mmz_logo")
                                    Image("LogoText")
                                }
                            }
                            .padding(.top,safeAreaInsets.top + 10)
                            .padding(.bottom, 30)
                            
                            //MARK:- Textfields
                            VStack(alignment: .leading, spacing: 20) {
                                //MARK:- Graident welcome view
                                WelcomeTextView(welcomeText: LocalizedString.Login.title,
                                                infotext: LocalizedString.Login.subtitle,
                                                colors: [Color.mamazuOrangeText, Color.mamazuPinkText])
                                
                                MamazuTextField(bindingText: $loginViewModel.email,
                                                placeholder: LocalizedString.emailPlaceholder,
                                                borderColor: Color.white,
                                                image: "envelope.badge")
                                    .textContentType(.emailAddress)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                
                                MamazuTextField(bindingText: $loginViewModel.password,
                                                placeholder: LocalizedString.passwordPlaceholder,
                                                borderColor: Color.white,
                                                image: "lock.circle",
                                                isPassword: true)
                                    .textContentType(.password)
                                
                                //TODO
    //                            Button(action: {}, label: {
    //                                Text("Şifremi Unuttum")
    //                                    .font(.subheadline)
    //                                    .foregroundColor(Color.mamazuWelcomeSubtitle)
    //                                    .frame(maxWidth: .infinity, alignment: .trailing)
    //                            })
                                
                                //MARK:- Login button
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .angularGradientGlow(colors: [Color(#colorLiteral(red: 0, green: 0.4366608262, blue: 1, alpha: 1)),
                                                                      Color(#colorLiteral(red: 0, green: 0.9882656932, blue: 0.6276883483, alpha: 1)),
                                                                      Color(#colorLiteral(red: 1, green: 0.9059918523, blue: 0.1592884958, alpha: 1)),
                                                                      Color(#colorLiteral(red: 1, green: 0.2200134695, blue: 0.2417424321, alpha: 1))])
                                        .blur(radius: 8)
                                        .opacity(0.8)
                                        .frame(maxWidth: size.width - 50)
                                        .frame(height: 50)
                                    Button(action: {
                                        loginViewModel.login()
                                        print(loginViewModel.isLoading)
                                    }, label: {
                                        Text(LocalizedString.Login.loginButtonTitle)
                                            .frame(maxWidth: size.width - 50)
                                            .frame(height: 50)
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .semibold))
                                            .cornerRadius(15)
                                    })
                                    .background(RadialGradient(colors: [Color.loginBtnBg, Color.loginBtnBg.opacity(0.7)], center: .center, startRadius: 50, endRadius: 300))
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(.white, lineWidth: 2)
                                                .blendMode(.softLight)
                                )
                                }
                                
                                
                                //MARK:- Go to register button
                                NavigationLink(destination: RegisterView(isLoggedIn: $loginViewModel.isLoggedIn)) {
                                    HStack {
                                        Text(LocalizedString.Login.notMember)
                                            .font(.system(size: 14, weight: .regular))
                                        Text(LocalizedString.Login.register)
                                            .font(.system(size: 14, weight: .bold))
                                    }
                                    .foregroundColor(.white.opacity(0.7))
                                    .padding(.leading, 7)
                                }
                                
                            }
                            .frame(maxWidth: 350)
                            .padding(.horizontal, 25)
                            .padding(.bottom, 20)
                            .background(
                                Color.loginBg.opacity(0.7)
                                    .cornerRadius(30)
                                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 15)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 30)
                                                .stroke(.white, lineWidth: 1)
                                                .blendMode(.softLight)
                                        )
                            )
        
                            .padding(.horizontal)
                            
                            .alert(isPresented: $loginViewModel.isLoginError, content: {
                                Alert(title: Text("Mamazu"), message: Text(loginViewModel.errorMessage), dismissButton: .default(Text(LocalizedString.ok)))
                            })
                            
                            .fullScreenCover(isPresented: $loginViewModel.isLoggedIn, content: {
                                if UIDevice.current.iPad {
//                                    NavigationView {
//                                        SideBar()
//                                        //SideBar().hideNavigationBar().accentColor(Color.mamazuTitle)
//                                    }
                                    
                                    SideBar()
                                        .accentColor(.mamazuTextColor)
                                    
                                } else {
                                    MamazuTab(selectedTab: $selectedTab)
                                }
                            })
                            
                        }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                    //MARK:- Loading animation
                    LoadingView(isShowing: $loginViewModel.isLoading, animationName: "Dog2")
                        .frame(width: size.width, height: size.height)
                        .background(Color.mamazuBackground.opacity(0.8))
                }
                    
                   
                
            }
            .onTapGesture {
                hideKeyboard()
            }
            .padding(.bottom, keyboardHandler.keyboardHeight)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("LoginBackground").resizable().scaledToFill())
            .ignoresSafeArea(.all)
            .navigationBarHidden(true)
            
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    locationManager.requestAuth()
                    if locationManager.locationStatus == nil || locationManager.locationStatus == .notDetermined {
                        locationManager.requestAuth()
                    }
                }
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .preferredColorScheme(.dark)
            LoginView()
                .preferredColorScheme(.light)
        }
    }
}
