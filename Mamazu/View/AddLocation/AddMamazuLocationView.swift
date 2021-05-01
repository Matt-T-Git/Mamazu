//
//  AddMamazuLocationView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 23.03.2021.
//

import SwiftUI
import MapKit

struct AddMamazuLocationView: View {
    let size = UIScreen.main.bounds
    
    @State var isTutorialShowing: Bool = true
    @State var isImageSelected: Bool = false
    @State var selectedImage: UIImage = UIImage()
    @State var isShowPicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State private var showingSheet = false
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = AddMamazuLocationVM()
    @StateObject var locationManager = LocationManager()
    @StateObject private var keyboardHandler = KeyboardHandler()
    
    @State var latitude = 0.0
    @State var longitude = 0.0
    
    var body: some View {
        let descriptionPlaceholder = "Detaylı açıklama! \nLütfen ne kadar yardıma ihtiyaç olduğu gibi bilgileri bu alanda bizimle paylaşınız."
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 15, content: {
                    //Image(uiImage: isImageSelected ? selectedImage : #imageLiteral(resourceName: "selectImageMamazu"))
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 180)
                        .background(Image("selectImageMamazu"))
                        .background(Color.mamazuBackground)
                        .cornerRadius(55, style: .continuous)
                        .padding(.bottom, 40)
                        .shadow(color: Color.mamazuCardShadow, radius: 15, x: 0, y: 10)
                        .onTapGesture {
                            self.showingSheet.toggle()
                        }
                        .actionSheet(isPresented: $showingSheet) {
                            ActionSheet(
                                title: Text("Mamazu"),
                                message: Text("Ekleyeceğiniz fotoğrafı kameranızı kullanarak çekebilir ya da galeriden seçebilirsiniz."),
                                buttons: [.default(Text("Kamerayı Kullan"), action: {
                                    self.sourceType = .camera
                                    self.isShowPicker.toggle()
                                }),
                                .default(Text("Galeriden Seç"), action: {
                                    self.sourceType = .photoLibrary
                                    self.isShowPicker.toggle()
                                }),
                                .cancel()]
                            )
                        }
                        .sheet(isPresented: $isShowPicker, content: {
                            SUImagePickerView(sourceType: sourceType,
                                              isPresented: self.$isShowPicker,
                                              image: self.$selectedImage,
                                              isImageSelected: $isImageSelected)
                        })
                    
                    VStack(spacing: 20) {
                        MamazuTextField(bindingText: $viewModel.title,
                                        placeholder: "Lokasyon Başlığı",
                                        borderColor: .mamazuCardGradientLeft,
                                        image: "location.fill")
                        
                        
                        MamazuTextEditor(bindingText: $viewModel.description,
                                         borderColor: .mamazuCardGradientLeft,
                                         image: "message.fill",
                                         placeholderText: descriptionPlaceholder)
                        
                        MamazuMapView(latitude: latitude, longitude: longitude, title: "Mamazu")
                            .frame(maxWidth: size.width - 45)
                            .height(150)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.mamazuCardGradientLeft, lineWidth: 1)
                            )
                            .padding(.bottom, 20)
                        
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                            RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                                .fill(LinearGradient(gradient: Gradient(colors: [.mamazuCardGradientLeft, .mamazuCardGradientRight]),
                                                                  startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                            Text("KONUMU KAYDET").font(.system(size: 16, weight: .bold, design: .rounded)).foregroundColor(.white)
                        }
                        .shadow(color: Color.mamazuCardGradientLeft.opacity(0.3), radius: 5, x: 0, y: 5)
                        .height(52)
                        .onTapGesture {
                            viewModel.image = selectedImage
                            viewModel.latitude = latitude
                            viewModel.longitude = longitude
                            viewModel.addMamazu()
                        }
                        .alert(isPresented: $viewModel.isError, content: {
                            Alert(title: Text("Mamazu"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("Tamam")))
                        })
                        
                       
                    }
                    .onChange(of: locationManager.lastLocation, perform: { _ in
                        self.latitude = locationManager.lastLocation?.coordinate.latitude ?? 0
                        self.longitude = locationManager.lastLocation?.coordinate.longitude ?? 0
                    })
                    .padding(.horizontal, 20)
                    
                })
                .padding(.bottom, keyboardHandler.keyboardHeight)
                .animation(.easeInOut)
                .frame(maxWidth: size.width, maxHeight: .infinity)
                .padding(.top, UIApplication.shared.windows.first!.safeAreaInsets.top + 30)
                .padding(.bottom, 40)
            }
            .background(Image("Addbackground").resizable())
            .background(.mamazuBackground)
            .frame(maxWidth: size.width, maxHeight: size.height)
            .onTapGesture {
                hideKeyboard()
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            .onChange(of: viewModel.isSuccess, perform: { _ in
                self.presentationMode.wrappedValue.dismiss()
            })
            
            TutorialView(warningText: .Mamazu, isShowing: $isTutorialShowing)
            
            LoadingView(isShowing: $viewModel.isLoading, animationName: "cat")
                .frame(maxWidth: size.width, maxHeight: size.height)
                .background(Color.mamazuBackground.opacity(0.8))
        }
    }
}

struct AddMamazuLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddMamazuLocationView()
    }
}
