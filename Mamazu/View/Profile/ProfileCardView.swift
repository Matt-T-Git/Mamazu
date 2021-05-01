////
////  ProfileCardView.swift
////  Mamazu
////
////  Created by Sercan Burak AĞIR on 2.04.2021.
////
//
//import SwiftUI
//
//struct ProfileCardView: View {
//    var body: some View {
//        VStack {
//            //MARK:- Top Card View
//            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
//                ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
//                    Rectangle()
//                        .fill(Color.mamazuCardBackground)
//                        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 45))
//                        .shadow(color: Color.mamazuCardShadow, radius: 10, x: 0, y: 10)
//                    HStack {
//                        Picker(selection: $selectedView, label: Text("")) {
//                            Text("Mamazu").tag(0)
//                            Text("Kayıp").tag(1)
//                        }
//                        .pickerStyle(SegmentedPickerStyle())
//                        .padding(.horizontal, 45)
//                        
//                    }
//                    .padding(.bottom, 10)
//                }
//                ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
//                    AnimatedImage(url: URL(string: userViewModel.imageUrl)).indicator(SDWebImageActivityIndicator.medium)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: size.width, height: size.height / 2)
//                        .background(Color.mamazuCardBackground)
//                        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 50))
//                    Rectangle()
//                        .fill(LinearGradient(gradient: Gradient(colors: [.mamazuPurple, .mamazuLostCardGradientRight]),
//                                             startPoint: .bottomLeading, endPoint: .topTrailing))
//                        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 45))
//                        
//                        .opacity(0.85)
//                    
//                    AnimatedImage(url: URL(string: userViewModel.imageUrl)).indicator(SDWebImageActivityIndicator.medium)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .cornerRadius(60, style: .continuous)
//                        .frame(width: size.width / 1.8, height: size.width / 1.8)
//                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 10)
//                    Text(userViewModel.userName).font(.system(size: 22, weight: .bold)).foregroundColor(.white)
//                        .padding(.top, size.width / 1.8 + 60)
//                }
//                .height(size.height / 2)
//            }
//            .overlay(
//                Button(action: {
//                    self.isShowingSheet.toggle()
//                }, label: {
//                    Image("Logout")
//                })
//                .actionSheet(isPresented: $isShowingSheet) {
//                    ActionSheet(
//                        title: Text("Mamazu"),
//                        message: Text("Çıkış yapmak istediğinize emin misiniz ?"),
//                        buttons: [.default(Text("Çıkış Yap"), action: {
//                            UserDefaults.standard.setIsLoggedIn(value: false)
//                            UserDefaults.standard.resetUserToken()
//                            self.isLogout.toggle()
//                        }),
//                        .cancel()]
//                    )
//                }
//                .fullScreenCover(isPresented: $isLogout) {
//                    LoginView()
//                }
//                .padding(.trailing, 20)
//                .padding(.top, UIApplication.shared.windows.first!.safeAreaInsets.top)
//                ,alignment: .topTrailing
//            )
//            .frame(width: size.width, height: size.height / 2 + 50)
//        }
//    }
//}
//
//struct ProfileCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileCardView()
//    }
//}
