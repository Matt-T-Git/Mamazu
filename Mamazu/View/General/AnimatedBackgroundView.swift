//
//  AnimatedBackgroundView.swift
//  Mamazu
//
//  Created by Sercan Burak AĞIR on 26.02.2021.
//

import SwiftUI

struct AnimatedBackgroundView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors = [Color.blue, Color.mamazuPurpleLight, Color.mamazuPurple, Color.mamazuTurquoise]
    
    @State private var start = UnitPoint(x: 0, y: -2)
    @State private var end = UnitPoint(x: 4, y: 0)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
                .animation(Animation.easeInOut(duration: 15).repeatForever())
                .onReceive(timer) { _ in
                    self.start = UnitPoint(x: 4, y: 0)
                    self.end = UnitPoint(x: 0, y: 2)
                    self.start = UnitPoint(x: -4, y: 5)
                    self.end = UnitPoint(x: 4, y: 0)
            }
        }
    }
}

struct AnimatedBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBackgroundView()
    }
}
