//
//  LocationCardView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 22.03.2021.
//

import SwiftUI

struct LocationCardView: View {
    var image: String = ""
    var title: String = ""
    
    var gradient: [Color] = [.white, .white]

    var body: some View {
        let size = UIScreen.main.bounds
        let radius: CGFloat = size.width / 12
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                
                //MARK:- Card
                RoundedRectangle(cornerRadius: radius, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .fill(Color.mamazuCardBackground)
                    .shadow(color: Color.mamazuCardShadow.opacity(0.8), radius: 10, x: 0, y: 10)
                
                //MARK:- Gradient Text
                GradientText(text: title.uppercased(), colors: gradient,
                             font: .system(size: 16, weight: .bold, design: .rounded))
                    .padding(.bottom, 9)
            }
            
            //MARK:- Gradient Card
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: gradient),
                                                  startPoint: .leading, endPoint: .trailing))
                .clipShape(RoundedRectangle(cornerRadius: radius, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                .padding(.bottom, 41)
                //.height(size.height / 3 - 33)
            
            //MARK:- Big Image
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width - 30, height: size.height / 3 - 95)
                .clipShape(RoundedRectangle(cornerRadius: radius, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                
                //.padding(.bottom, 45)
                
        }
        .frame(width: size.width - 30, height: size.height / 3 - 50)
    }
}

struct LocationCardView_Previews: PreviewProvider {
    static var previews: some View {
        LocationCardView()
    }
}
