//
//  AddLostPetView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 24.03.2021.
//

import SwiftUI

struct AddLostPetView: View {
    
    let size = UIScreen.main.bounds
    
    @State var isTutorialShowing: Bool = true
    @State var isImageSelected: Bool = false
    @State var selectedImage: UIImage = UIImage()
    @State var isShowPicker: Bool = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State private var showingSheet = false
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = AddLostLocationVM()
    @StateObject var locationManager = LocationManager()
    @StateObject private var keyboardHandler = KeyboardHandler()
    
    @State var latitude = 0.0
    @State var longitude = 0.0
    @State var isLocationSelected = false
    
    @State var isLostMapViewShow: Bool = false
    
    var body: some View {
        let descriptionPlaceholder = LocalizedString.AddLocation.lostPetDescriptionPlaceholder
        let borderColor = Color.mamazuLostCardGradientRight.opacity(0.5)
        
        ZStack {
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
                                message: Text(LocalizedString.AddLocation.galleryDescription),
                                buttons: [.default(Text(LocalizedString.useCamera), action: {
                                    self.sourceType = .camera
                                    self.isShowPicker.toggle()
                                }),
                                .default(Text(LocalizedString.selectFromGallery), action: {
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
                        MamazuTextField(bindingText: $viewModel.petName,
                                        placeholder: LocalizedString.AddLocation.animalNamePlaceholder,
                                        borderColor: borderColor,
                                        image: "doc.append.fill")
                        
                        MamazuTextField(bindingText: $viewModel.petBreed,
                                        placeholder: LocalizedString.AddLocation.breedPlaceholder,
                                        borderColor: borderColor,
                                        image: "sun.max.fill")
                        
                        MamazuPicker(selectedText: $viewModel.petAge,
                                     placeholder: LocalizedString.AddLocation.agePlaceholder,
                                     borderColor: borderColor,
                                     list: viewModel.petAgeArray,
                                     image: "infinity.circle")
                        
                        MamazuPicker(selectedText: $viewModel.petGender,
                                     placeholder: LocalizedString.AddLocation.genderPlaceholder,
                                     borderColor: borderColor,
                                     list: viewModel.petGenderArray,
                                     image: "mustache.fill")
                        
                        MamazuTextEditor(bindingText: $viewModel.description,
                                         borderColor: borderColor,
                                         image: "message.fill",
                                         placeholderText: descriptionPlaceholder)
                        
                        MamazuMapView(latitude: latitude, longitude: longitude, title: "Mamazu")
                            .frame(maxWidth: .infinity - 45)
                            .height(140)
                            .cornerRadius(20)
                            .overlay(
                                ZStack {
                                    RadialGradient(gradient: Gradient(colors: [.mamazuCardGradientRight, .mamazuCardGradientLeft]),
                                                   center: .topLeading, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: 150).opacity(0.5)
                                    RadialGradient(gradient: Gradient(colors: [.mamazuLostCardGradientRight, Color.mamazuCardGradientLeft.opacity(0)]),
                                                   center: .bottomTrailing, startRadius: 40, endRadius: 200).opacity(0.5)
                                    Text(isLocationSelected ? LocalizedString.AddLocation.locationSelected : LocalizedString.AddLocation.selectLocation)
                                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                                        .foregroundColor(Color.init(.sRGB, white: 0.9, opacity: 1))
                                }
                                .cornerRadius(20)
                            )
                            .padding(.bottom, 20)
                            
                            .onTapGesture {
                                self.isLostMapViewShow.toggle()
                            }
                            .sheet(isPresented: $isLostMapViewShow, content: {
                                ChooseLocationMapView(latitude: $latitude, longitude: $longitude, isSelected: $isLocationSelected)
                            })
                        
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                            RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                                .fill(LinearGradient(gradient: Gradient(colors: [.mamazuLostCardGradientLeft, .mamazuLostCardGradientRight]),
                                                     startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                            Text(LocalizedString.AddLocation.saveLocationButtonTitle).font(.system(size: 16, weight: .bold, design: .rounded)).foregroundColor(.white)
                        }
                        .shadow(color: Color.mamazuCardGradientLeft.opacity(0.3), radius: 5, x: 0, y: 5)
                        .height(52)
                        .padding(.bottom, UIApplication.shared.windows.first!.safeAreaInsets.bottom + 60)
                        .onTapGesture {
                            viewModel.image = selectedImage
                            viewModel.latitude = latitude
                            viewModel.longitude = longitude
                            viewModel.isLocationSelected = isLocationSelected
                            viewModel.addLostPet()
                        }
                        .alert(isPresented: $viewModel.isError, content: {
                            Alert(title: Text("Mamazu"), message: Text(viewModel.errorMessage), dismissButton: .default(Text(LocalizedString.ok)))
                        })
                        
                        
                    }
                    .onChange(of: locationManager.lastLocation, perform: { _ in
                        self.latitude = locationManager.lastLocation?.coordinate.latitude ?? 0
                        self.longitude = locationManager.lastLocation?.coordinate.longitude ?? 0
                    })
                    .padding(.horizontal, 20)
                    
                })
                .padding(.top, UIApplication.shared.windows.first!.safeAreaInsets.top + 30)
                .frame(maxWidth: size.width, maxHeight: .infinity)
                .padding(.bottom, keyboardHandler.keyboardHeight)
                .animation(.easeInOut)
            }
            .onChange(of: viewModel.isSuccess, perform: { _ in
                self.presentationMode.wrappedValue.dismiss()
            })
            
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
            
            TutorialView(warningText: .Lost, isShowing: $isTutorialShowing)
            
            LoadingView(isShowing: $viewModel.isLoading, animationName: "cat")
                .frame(maxWidth: size.width, maxHeight: size.height)
                .background(Color.mamazuBackground.opacity(0.8))
        }
    }
}

struct AddLostPetView_Previews: PreviewProvider {
    static var previews: some View {
        AddLostPetView()
    }
}
