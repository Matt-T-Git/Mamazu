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
    
    @StateObject private var keyboardHandler = KeyboardHandler()
    @StateObject private var registerViewModel = RegisterViewModel()
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            ZStack {
                VStack {
                    WelcomeTextView(welcomeText: "Aramıza Hoşgeldiniz!",
                                    infotext: "Devam etmek için formu doldurun.",
                                    colors: [Color.mamazuBrightTurquoise, Color.mamazuJava])
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 180)
                        .background(Image("selectImageMamazu"))
                        .cornerRadius(55, style: .continuous)
                        .padding(.bottom, 40)
                        .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 10)
                        .onTapGesture {
                            self.isShowGallery.toggle()
                        }
                        .sheet(isPresented: $isShowGallery, content: {
                            ImagePicker(isPresented: self.$isShowGallery, image: self.$selectedImage, isImageSelected: $isImageSelected, sourceType: .photoLibrary)
                        })
                    //Text Inputs
                    VStack(alignment: .leading, spacing: 25) {
                        MamazuTextField(bindingText: $registerViewModel.name,
                                        placeholder: "Adınız ve Soyadınız",
                                        borderColor: Color.mamazuDarkPink.opacity(0.5),
                                        image: "person.fill")
                            .textContentType(.name)
                            .autocapitalization(.words)
                        MamazuTextField(bindingText: $registerViewModel.email,
                                        placeholder: "Email Adresiniz",
                                        borderColor: Color.mamazuDarkPink.opacity(0.5),
                                        image: "envelope.badge")
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        MamazuTextField(bindingText: $registerViewModel.password,
                                        placeholder: "Şifreniz",
                                        borderColor: Color.mamazuDarkPink.opacity(0.5),
                                        image: "lock.fill",
                                        isPassword: true)
                            .textContentType(.password)
                    }
                    
                    .padding(.horizontal, 25)
                    .padding(.bottom, 20)
                    
                    Button(action: {
                        registerViewModel.image = selectedImage
                        registerViewModel.registerUser()
                    }, label: {
                        Text("KAYIT OL")
                            .frame(maxWidth: size.width - 50)
                            .frame(height: 55)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                            .cornerRadius(15, style: .continuous)
                        
                    })
                    .fullScreenCover(isPresented: $registerViewModel.isRegistered, content: {
                        MamazuTabView()
                    })
                    .alert(isPresented: $registerViewModel.isRegisterError, content: {
                        Alert(title: Text("Mamazu"),
                              message: Text(registerViewModel.errorMessage),
                              dismissButton: .default(Text("Tamam")))
                    })
                    
                    .background(LinearGradient(gradient: Gradient(colors: [.mamazuLostCardGradientLeft, .mamazuLostCardGradientRight]),
                                               startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                    
                    
                    Spacer(minLength: 40)
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Text("Zaten üye misiniz?")
                                .font(.system(size: 14, weight: .regular))
                            Text("GİRİŞ YAPIN.")
                                .font(.system(size: 14, weight: .heavy))
                        }
                    })
                    .foregroundColor(Color.white)
                    .padding(.bottom, 30)
                }
                LoadingView(isShowing: $registerViewModel.isLoading, animationName: "Dog2")
                    .frame(width: size.width, height: size.height)
                    .background(Color.mamazuBackground.opacity(0.8))
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .background(Color.black.opacity(registerViewModel.isLoading ? 0.7 : 0)).animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
        .padding(.bottom, keyboardHandler.keyboardHeight)
        .animation(.easeInOut)
        .frame(maxWidth: size.width, maxHeight: size.height)
        .background(LinearGradient(gradient: Gradient(colors: [Color.mamazuPurple, Color.mamazuLoginGradientDark]),
                                   startPoint: .topLeading,
                                   endPoint: .center))
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .navigationBarHidden(true)
    }
}

struct RegisterScrollView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isLoggedIn: Binding.constant(false))
    }
}


