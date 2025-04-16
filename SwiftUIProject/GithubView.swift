//
//  GithubView.swift
//  SwiftUIProject
//
//  Created by Mohammad on 4/16/25.
//

import SwiftUI

struct ContributionsView: View {
    @State private var isAnimating = false
    
    let weeks = 23 // I only used 23 weeks of data because it fits better in the view
    let daysPerWeek = 7 // 7 days a week
    var rows: Array<GridItem> { Array(repeating: GridItem(.flexible()), count: daysPerWeek) }

    var body: some View {
        VStack {
                Group {
                    Text("..........")
                    Image(.mark)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .foregroundStyle(isAnimating ? .indigo : .gray)
                .font(.largeTitle.weight(.semibold))
                .animation(.easeInOut(duration: 1.0)
                        .delay(0.01)
                        .repeatForever(autoreverses: true), value: isAnimating)
               .frame(width: isAnimating ? 100 : 0)
            
            Spacer().frame(height: 50)
            
            HStack {
                LazyHGrid(rows: rows, spacing: 2) {
                    ForEach(0..<weeks*daysPerWeek, id: \.self) { item in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(isAnimating ? Color("gitColor") : (item % 5 == 0 ? Color("gitColor") : item % 4 == 0 ? .green : .green.opacity(0.4)))
                            .frame(width: 15, height: 15)
                            .animation(
                                .easeInOut(duration: 1.0)
                                .delay(Double(item) * 0.02)
                                .repeatForever(autoreverses: true),
                                value: isAnimating
                            )
                    }
                }
                .padding(.horizontal, 5)
                .frame(height: 120)
               // .drawingGroup() // if use this cant see this animation
            }
            
            Spacer()
        }
        .onAppear {
            Task {
                await MainActor.run {
                    withAnimation {
                        isAnimating = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContributionsView()
}
