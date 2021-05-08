//
//  ContentView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 22.02.2021.
//

import SwiftUI

struct LoginView: View {
    
    var size = UIScreen.main.bounds
    
    @State var isRegistrationViewShow: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var keyboardHandler = KeyboardHandler()
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var locationManager: LocationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    //MARK:- Login Stack
                    VStack(alignment: .center, spacing: 4) {
                        //MARK:- Graident welcome view
                        WelcomeTextView(welcomeText: LocalizedString.Login.welcomeBack,
                                        infotext: LocalizedString.Login.signInContinue,
                                        colors: [Color.mamazuNeonCarrot, Color.mamazuWildStrawberry])
                        //MARK:- Logo View
                        LogoView(width: 220, height: 175, padding: .bottom, paddingSize: 30)
                        
                        //MARK:- Textfields
                        VStack(alignment: .leading, spacing: 25) {
                            MamazuTextField(bindingText: $loginViewModel.email,
                                            placeholder: LocalizedString.Login.emailPlaceholder,
                                            borderColor: Color.mamazuDarkPink.opacity(0.5),
                                            image: "envelope.badge")
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                            
                            MamazuTextField(bindingText: $loginViewModel.password,
                                            placeholder: LocalizedString.Login.passwordPlaceholder,
                                            borderColor: Color.mamazuDarkPink.opacity(0.5),
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
                        }
                        .padding(.horizontal, 25)
                        .padding(.bottom, 20)
                        
                        //MARK:- Login button
                        Button(action: {
                            loginViewModel.loginUser()
                            print(loginViewModel.isLoading)
                        }, label: {
                            Text(LocalizedString.Login.loginString)
                                .frame(maxWidth: size.width - 50)
                                .frame(height: 55)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .semibold))
                                .cornerRadius(15, style: .continuous)
                        })
                        .alert(isPresented: $loginViewModel.isLoginError, content: {
                            Alert(title: Text("Mamazu"), message: Text(loginViewModel.errorMessage), dismissButton: .default(Text(LocalizedString.ok)))
                        })
                        .fullScreenCover(isPresented: $loginViewModel.isLoggedIn, content: {
                            if UIDevice.current.iPad {
                                NavigationView {
                                    SideBar().hideNavigationBar().accentColor(.mamazuTitle)
                                }
                            } else {
                                MamazuTabView()
                            }
                        })
                        .background(LinearGradient(gradient: Gradient(colors: [.mamazuCardGradientLeft, .mamazuCardGradientRight]),
                                                   startPoint: .topLeading, endPoint: .bottomTrailing))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                        
                        //MARK:- Go to register button
                        NavigationLink(destination: RegisterView(isLoggedIn: $loginViewModel.isLoggedIn)) {
                            HStack {
                                Text(LocalizedString.Login.notMember)
                                    .font(.system(size: 14, weight: .regular))
                                Text(LocalizedString.Login.register)
                                    .font(.system(size: 14, weight: .heavy))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 50)
                        
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
            .background(LinearGradient(gradient: Gradient(colors: [Color.mamazuPurple, Color.mamazuLoginGradientDark]),
                                       startPoint: .topLeading,
                                       endPoint: .center))
            .ignoresSafeArea(.all)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .preferredColorScheme(.dark)
        }
    }
}
