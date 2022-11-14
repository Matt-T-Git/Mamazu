//
//  RegisterView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 25.02.2021.
//

import SwiftUI
import Photos

struct RegisterView: View {
    var size = UIScreen.main.bounds
    
    @State var isImageSelected: Bool = false
    @State var isShowGallery:Bool = false
    @State var selectedImage = UIImage()
    
    @Binding var isLoggedIn: Bool
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @StateObject private var keyboardHandler = KeyboardHandler()
    @StateObject private var registerViewModel = RegisterViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            ZStack {
                VStack {
                    
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 180)
                        .background(Image("selectImageMamazu"))
                        .cornerRadius(55)
                        .padding(.bottom, 30)
                        .padding(.top, safeAreaInsets.top + 20)
                        .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 10)
                        .onTapGesture {
                            self.isShowGallery.toggle()
                        }
                        .sheet(isPresented: $isShowGallery, content: {
                            ImagePicker(isPresented: self.$isShowGallery, image: self.$selectedImage, isImageSelected: $isImageSelected, sourceType: .photoLibrary)
                        })
                    
                    //Text Inputs
                    VStack(alignment: .leading, spacing: 25) {
                        
                        WelcomeTextView(welcomeText: LocalizedString.Register.title,
                                        infotext: LocalizedString.Register.subtitle,
                                        colors: [Color.mamazuBrightTurquoise, Color.mamazuJava])
                        
                        MamazuTextField(bindingText: $registerViewModel.name,
                                        placeholder: LocalizedString.Register.namePlaceholder,
                                        borderColor: .white,
                                        image: "person.fill")
                            .textContentType(.name)
                            .autocapitalization(.words)
                        MamazuTextField(bindingText: $registerViewModel.email,
                                        placeholder: LocalizedString.emailPlaceholder,
                                        borderColor: .white,
                                        image: "envelope.badge")
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        MamazuTextField(bindingText: $registerViewModel.password,
                                        placeholder: LocalizedString.passwordPlaceholder,
                                        borderColor: .white,
                                        image: "lock.fill",
                                        isPassword: true)
                            .textContentType(.password)
                        
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
                                registerViewModel.image = selectedImage
                                registerViewModel.register()
                            }, label: {
                                Text(LocalizedString.Register.registerButtonTitle)
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
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack {
                                Text(LocalizedString.Register.alreadyMember)
                                    .font(.system(size: 14, weight: .regular))
                                Text(LocalizedString.Register.login)
                                    .font(.system(size: 14, weight: .heavy))
                            }
                        })
                        .foregroundColor(Color.white.opacity(0.7))
                        .padding(.leading, 7)
                    }
                    //.preferredColorScheme(.dark)
                    .frame(maxWidth: 350)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 20)
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
                    
                    .fullScreenCover(isPresented: $registerViewModel.isRegistered, content: {
                        MamazuTabView()
                    })
                    .alert(isPresented: $registerViewModel.isRegisterError, content: {
                        Alert(title: Text("Mamazu"),
                              message: Text(registerViewModel.errorMessage),
                              dismissButton: .default(Text(LocalizedString.ok)))
                    })
                    
                    Spacer(minLength: 40)
                    
                    
                }
                LoadingView(isShowing: $registerViewModel.isLoading, animationName: "Dog2")
                    .frame(width: size.width, height: size.height)
                    .background(Color.mamazuBackground.opacity(0.8))
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .background(Color.black.opacity(registerViewModel.isLoading ? 0.7 : 0)).animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: registerViewModel.isLoading)
        .padding(.bottom, keyboardHandler.keyboardHeight)
        .animation(.easeInOut, value: 0)
        .frame(maxWidth: size.width, maxHeight: size.height)
        .background(Image("LoginBackground").resizable().scaledToFill())
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .navigationBarHidden(true)
    }
}

struct RegisterScrollView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isLoggedIn: Binding.constant(false))
    }
}


