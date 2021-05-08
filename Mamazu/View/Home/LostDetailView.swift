//
//  LostDetailView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 19.03.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct LostDetailView: View {
    
    var size = UIScreen.main.bounds
    var lostData: LostAnimalResults
    
    @Binding var isShow: Bool
    @State var isShowingSheet:Bool = false
    @State var isShowingAlert:Bool = false
    @AppStorage("userId") var userID = "0"
    
    @StateObject var lostViewModel = LostViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ScrollView {
            
            //MARK:- Top Card View
            VStack {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                        
                        //MARK:- Card
                        Rectangle()
                            .fill(Color.mamazuCardBackground)
                            .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 45))
                            .shadow(color: Color.mamazuCardShadow, radius: 10, x: 0, y: 10)
                        
                        //MARK:- Profile Stack
                        HStack {
                            AnimatedImage(url: URL(string: lostData.user.profileImg)).indicator(SDWebImageActivityIndicator.medium)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .cornerRadius(18, style: .continuous)
                            VStack(alignment: .leading, spacing: 0){
                                Text(lostData.user.name).font(.system(size: 15, weight: .bold)).foregroundColor(Color.mamazuTextColor)
                                Text(timeAgoFrom(lostData.date)).font(.system(size: 12, weight: .regular)).foregroundColor(Color.mamazuTextCaption)
                            }
                        }
                        .padding(.bottom, 10)
                        .padding(.leading, 25)
                    }
                    
                    //MARK:- Gradient Card
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.mamazuLostCardGradientLeft, .mamazuLostCardGradientRight]),
                                             startPoint: .leading, endPoint: .trailing))
                        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 45))
                        .height(size.height / 2 + 7)
                    
                    //MARK:- Lost Animal Image
                    AnimatedImage(url: URL(string: lostData.image)).indicator(SDWebImageActivityIndicator.medium)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: size.width)
                        .height(size.height / 2)
                        .background(Color.mamazuCardBackground)
                        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 50))
                }
                .overlay(
                    Button(action: {
                        withAnimation {
                            self.isShow = false
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("Close")
                    })
                    .padding(.trailing, 20)
                    .padding(.top, UIApplication.shared.windows.first!.safeAreaInsets.top)
                    ,alignment: .topTrailing
                )
                .frame(maxWidth: size.width)
                .height(size.height / 2 + 83)
            }
            
            //MARK:- Detail Stack
            VStack() {
                //MARK:- Pet Name
                GradientText(text: lostData.petName, colors: [.mamazuLostCardGradientLeft, .mamazuLostCardGradientRight],
                             font: .system(size: 24, weight: .bold, design: .rounded))
                    .frame(maxWidth: size.width, maxHeight: 28, alignment: .leading)
                //MARK:- Pet Detai Stack
                HStack {
                    VStack(alignment: .leading, spacing: 8){
                        Text(LocalizedString.Home.gender).font(.system(size: 16, weight: .bold)).foregroundColor(Color.mamazuTextColor)
                        Text(lostData.petBreed).font(.system(size: 13, weight: .regular)).foregroundColor(Color.mamazuTextCaption)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 8){
                        Text(LocalizedString.Home.breed).font(.system(size: 16, weight: .bold)).foregroundColor(Color.mamazuTextColor)
                        Text(lostData.petGender).font(.system(size: 13, weight: .regular)).foregroundColor(Color.mamazuTextCaption)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 8){
                        Text(LocalizedString.Home.age).font(.system(size: 16, weight: .bold)).foregroundColor(Color.mamazuTextColor)
                        Text(lostData.petAge == LocalizedString.Home.under1Year ? lostData.petAge : "\(lostData.petAge) \(LocalizedString.Home.yearsOfAge)")
                            .font(.system(size: 13, weight: .regular)).foregroundColor(Color.mamazuTextCaption)
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: size.width)
                Divider().padding(.top, 10)
                
                //MARK:- Found Button
                if !lostData.isFound && lostData.user.id == userID {
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                        RoundedRectangle(cornerRadius: 15, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                            .fill(LinearGradient(gradient: Gradient(colors: [.mamazuCardGradientLeft, .mamazuCardGradientRight]),
                                                 startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                        Text(LocalizedString.Home.found).font(.system(size: 16, weight: .bold, design: .rounded)).foregroundColor(.white)
                    }
                    .shadow(color: Color.mamazuCardGradientLeft.opacity(0.3), radius: 5, x: 0, y: 5)
                    .height(52)
                    .padding(.top, 10)
                    .onTapGesture {
                        self.isShowingSheet.toggle()
                    }
                    .actionSheet(isPresented: $isShowingSheet) {
                        ActionSheet(
                            title: Text("Mamazu"),
                            message: Text(LocalizedString.Home.areYouSureFound),
                            buttons: [.default(Text(LocalizedString.Home.yesFound), action: {
                                lostViewModel.id = lostData.id
                                lostViewModel.found()
                            }),
                            .cancel()]
                        )
                    }
                    .alert(isPresented: $lostViewModel.isError, content: {
                        Alert(title: Text("Mamazu"), message: Text(lostViewModel.errorMessage), dismissButton: .default(Text(LocalizedString.ok.uppercased())))
                    })
                    Divider().padding(.top, 10)
                }
                
                //MARK:- Description Text
                Text(lostData.description).font(.system(size: 14, weight: .regular)).foregroundColor(Color.mamazuTextCaption)
                    .lineSpacing(3)
                    .frame(maxWidth: size.width - 45, alignment: .leading)
                    .padding(.top, 5)
                
                Divider().padding(.top, 10)
                
                //MARK:- Map View
                MamazuMapView(latitude: lostData.location.coordinates[1], longitude: lostData.location.coordinates[0], title: lostData.petName)
                    
                    .frame(maxWidth: size.width)
                    .height(150)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.mamazuLostCardGradientLeft, lineWidth: 1)
                    )
                    .padding(.vertical, 10)
                    .padding(.bottom, 40)
                
            }
            .frame(maxWidth: size.width)
            .padding(.horizontal, 25)
            .padding(.top, 15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mamazuBackground)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .opacity(isShow ? 1 : 0)
        .animation(.easeInOut(duration: 0.8))
    }
}

struct LostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserModel(id: "5edf2cfb1800575cd00e9109",
                             name: "Sercan Burak AĞIR",
                             email: "sercanburak@gmail.com",
                             profileImg: "https://www.mamazuapp.com/profileImages/40e6d246-6101-4b9a-b7a6-39d66b5273df.png")
        
        let location = Location(type: "Point",
                                coordinates: [36.85789856768421, 30.76025889471372])
        
        let lost = LostAnimalResults(id: "1",
                                     description: "Adı Kuzey 1 yaşında bir gözü mavi diğer gözü sarı 1 haftadır kayıp. Fener mahallesi pamukkale market yakınlarında kayboldu. 0507 445 80 11 nolu numaradan ulaşabilirsiniz. İlan pamukkale markete aittir iletişime geçebilirsiniz.",
                                     image: "https://www.mamazuapp.com/lostAnimalImages/597ae3ba-650f-4787-8089-ebd847e38b1d.jpg",
                                     petName: "Kuzey",
                                     petAge: "1",
                                     petGender: "Dişi",
                                     petBreed: "Karma",
                                     date: "2020-06-10T12:42:23.314Z",
                                     isFound: false,
                                     user: user,
                                     location: location)
        Group {
            LostDetailView(lostData: lost, isShow: .constant(true))
                .preferredColorScheme(.dark)
        }
    }
}


