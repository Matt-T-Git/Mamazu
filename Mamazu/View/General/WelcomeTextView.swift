//
//  WelcomeTextView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 24.02.2021.
//

import SwiftUI

struct WelcomeTextView: View {
    var size = UIScreen.main.bounds
    var welcomeText: String = ""
    var infotext: String = ""
    var colors: [Color] = []
    
    init(welcomeText: String, infotext: String, colors: [Color]) {
        self.welcomeText = welcomeText
        self.infotext = infotext
        self.colors = colors
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            GradientText(text: welcomeText,
                         colors: colors,
                         font: .system(size: 30, weight: .semibold))
            Text(infotext)
                .font(.system(size: 15, weight: .regular, design: .default))
                .foregroundColor(Color.mamazuWelcomeSubtitle)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 25)
        .padding(.bottom, 40)
        .padding(.top, UIApplication.shared.windows.first!.safeAreaInsets.top + 10)
        //.padding(.top, size.height / 9)
    }
}

struct WelcomeTextView_Previews: PreviewProvider {
    static var previews: some View {
        //[Color.mamazuPastelRed, Color.mamazuRadicalRed]
        WelcomeTextView(welcomeText: LocalizedString.Login.title,
                        infotext: LocalizedString.Login.subtitle,
                        colors: [Color.mamazuNeonCarrot, Color.mamazuWildStrawberry])
    }
}
