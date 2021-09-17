//
//  TrackableSrollView.swift
//  TrackableSrollView
//
//  Created by Sercan Burak AĞIR on 1.09.2021.
//

import SwiftUI

struct TrackableScrollView<Content: View>: View {
    
    let axes: Axis.Set
    let offsetChanged: (CGPoint) -> ()
    let content: Content
    
    init(axes: Axis.Set = .vertical, offsetChanged: @escaping(CGPoint) -> () = { _ in }, @ViewBuilder content: () -> Content){
        self.axes = axes
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    var body: some View {
        ScrollView(axes) {
            GeometryReader{ geometry in
                Color.clear.preference(key: ScrollOffsetPreferanceKey.self, value: geometry.frame(in: .named("scrollView")).origin)
            }
            .frame(width: 0, height: 0)
            
            content
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollOffsetPreferanceKey.self, perform: offsetChanged)
    }
}

private struct ScrollOffsetPreferanceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
