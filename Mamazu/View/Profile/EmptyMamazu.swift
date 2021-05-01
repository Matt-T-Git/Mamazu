//
//  Empty.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 2.04.2021.
//

import SwiftUI

struct EmptyMamazu: View {
    
    var size = UIScreen.main.bounds
    private let animation = Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
    private let maxScale: CGFloat = 1.1
    @State var isAtMaxScale = false
    
    var closure: () -> Void = {}
    var title: String = ""
    
    var body: some View {
        
        VStack(spacing: 24) {
            Text(title)
                .foregroundColor(.mamazuTextColor)
                .font(.system(size: 18, weight: .medium, design: .rounded))
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .fill(Color.mamazuDarkPink)
                    .frame(width: size.width - 120, height: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .shadow(color: Color.mamazuDarkPink.opacity(0.7), radius: 20, x: 0, y: isAtMaxScale ? 5 : 20)
                
                Text("Yeni Kayıt Ekle")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
            }
            .scaleEffect(isAtMaxScale ? maxScale : 0.9)
            .onAppear {
                withAnimation(self.animation, {
                    self.isAtMaxScale.toggle()
                })
            }
            .onTapGesture {
                closure()
            }
        }
        
    }
}

struct EmptyMamazu_Previews: PreviewProvider {
    static var previews: some View {
        EmptyMamazu {
            print("Mamazu")
        }
//        EmptyMamazu()
//            .preferredColorScheme(.light)
    }
}
