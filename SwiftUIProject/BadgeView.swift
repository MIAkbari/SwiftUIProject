//
//  BadgeView.swift
//  SwiftUIProject
//
//  Created by Mohammad on 4/14/25.
//

import SwiftUI

struct BadgeColorKey: EnvironmentKey {
    static var defaultValue: Color? = nil
}

extension EnvironmentValues {
    var badgeColor: Color? {
        get { self[BadgeColorKey.self] }
        set { self[BadgeColorKey.self] = newValue }
    }
}

struct BadgeCircleView: View {
    
    var count: Int
    @Environment(\.badgeColor) var color
    
    var body: some View {
        Circle()
            .fill(color ?? .accentColor)
            .frame(width: 24, height: 24)
            .overlay {
                Text("\(count)")
                    .font(.footnote)
                    .foregroundStyle(.white)
                    .contentTransition(.numericText())
                    .animation(.easeInOut, value: count)
            }
    }
}

struct BadgeViewModifier: ViewModifier {
    
    var count: Int = 0
    var alignment: Alignment
    
    func body(content: Content) -> some View {
        content.overlay(
            ZStack {
                if count >= 1 {
                    BadgeCircleView(count: count)
                        .animation(.none, value: false) // because some numbers is worn for show transaction
                        .transition(.scale)
                }
            }
            // use alignment guide because cont move all view to  other align if use offset
            .alignmentGuide(alignment.horizontal, computeValue: { $0[HorizontalAlignment.center]})
            .alignmentGuide(alignment.vertical, computeValue: { $0[HorizontalAlignment.center]})
            , alignment: alignment)
    }
}

extension View {
    func badgeColor(_ color: Color?) -> some View {
        environment(\.badgeColor, color)
    }
    
    func badge(count: Int, alignment: Alignment = .topTrailing) -> some View {
        modifier(BadgeViewModifier(count: count, alignment: alignment))
    }
}

struct BadgeView: View {
    
    @State var counter: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, SwiftUI")
                .foregroundStyle(.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).fill(.orange))
                .badge(count: counter, alignment: .topTrailing)
                .badgeColor(.teal)
            
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.red)
                    .frame(width: 75, height: 75)
                    .badge(count: counter, alignment: .topLeading)
                    .badgeColor(.black)
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(.brown)
                    .frame(width: 75, height: 75)
                    .badge(count: counter, alignment: .bottomTrailing)
                    .badgeColor(.indigo)
                
            }
            
            Stepper("Count: \(counter)", value: $counter.animation(.bouncy))
        }
        .padding()
    }
}

#Preview {
    BadgeView()
}
