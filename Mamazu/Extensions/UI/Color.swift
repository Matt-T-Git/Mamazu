//
//  Color.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 22.02.2021.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    public static var mamazuPurpleLight = Color("MamazuPurpleLight")
    public static var mamazuPurple = Color("MamazuPurple")
    public static var mamazuDarkPink = Color("MamazuDarkPink")
    public static var mamazuLightPink = Color("MamazuLightPink")
    public static var mamazuTurquoise = Color("MamazuTurquoise")
    public static var mamazuYellow = Color("MamazuYellow")
    public static var mamazuPastelRed = Color("PastelRed")
    public static var mamazuRadicalRed = Color("RadicalRed")
    public static var mamazuNeonCarrot = Color("NeonCarrot")
    public static var mamazuWildStrawberry = Color("WildStrawberry")
    public static var mamazuBrightTurquoise = Color("BrightTurquoise")
    public static var mamazuJava = Color("Java")
    public static var mamazuDiscount = Color("Discount")
    public static var mamazuDiscountLight = Color("DiscountLight")
    
    public static var mamazuBackground = Color("mamazuBackground")
    
    public static var mamazuLoginGradientDark = Color("LoginGradientDark")
    public static var mamazuLoginGradientLight = Color("LoginGradientLight")
    
    //Text
    public static var mamazuPlaceholder = Color("Placeholder")
    public static var mamazuTitle = Color("TitleColor")
    public static var mamazuWelcomeSubtitle = Color("WelcomeSubtitle")
    public static var mamazuTextColor = Color("TextColor")
    public static var mamazuHeaderWelcometext = Color("HeaderWelcometext")
    public static var mamazuTextCaption = Color("TextCaption")
    
    public static var mamazuTextFieldColor = Color("TextFieldColor")
    public static var mamazuTextFieldPlaceholderBg = Color("TextFieldPlaceholderBg")
    
    //Lost Gradient
    public static var mamazuLostCardGradientLeft = Color("mamazuLostCardGradientLeft")
    public static var mamazuLostCardGradientRight = Color("mamazuLostCardGradientRight")
    
    //Mamazu Gradient
    public static var mamazuCardGradientLeft = Color("mamazuCardGradientLeft")
    public static var mamazuCardGradientRight = Color("mamazuCardGradientRight")
    
    public static var mamazuCardBackground = Color("CardBG")
    public static var mamazuCardShadow = Color("CardShadow")
    public static var mamazuTabItem = Color("TabItemColor")
    
    //Map Box Gradients
    
    public static var DarkBoxLeft = Color("DarkBoxLeft")
    public static var DarkBoxRight = Color("DarkBoxRight")
    
    public static var LightBoxLeft = Color("LightBoxLeft")
    public static var LightBoxRight = Color("LightBoxRight")
    
    public static var MidBoxLeft = Color("MidBoxLeft")
    public static var MidBoxRight = Color("MidBoxRight")
    
    
    
    
}


