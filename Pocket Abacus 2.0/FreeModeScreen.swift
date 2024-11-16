//
//  FreeModeScreen.swift
//  Pocket Abacus 2.0
//
//  Created by Steven Ongkowidjojo on 15/11/24.
//

import SwiftUI

struct FreeModeScreen: View {
    @State private var beads: [[Bool]] = Array(repeating: Array(repeating: false, count: 4), count: 7)
    @State private var upperBeads: [Bool] = Array(repeating: false, count: 7)
    @State private var counts: [Int] = Array(repeating: 0, count: 7)
    
    @Environment(Router.self) private var router
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer().frame(height: 10)
                    HStack {
                        Button(action: {
                            router.navigateBack()
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundStyle(.white)
                                .font(.system(size: 40))
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            router.navigate(to: .howToPlay)
                        }) {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundStyle(.white)
                                .font(.system(size: 40))
                        }
                    }
                    
                    Spacer().frame(height: 8)
                    
                    // Display counts above each column
                    HStack(spacing: 24) {
                        Spacer().frame(width: 72)
                        ForEach(0..<7) { index in
                            Text("\(counts[index])")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                                .frame(width: 60)
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            resetAbacus()
                        }) {
                            VStack {
                                Image(systemName: "arrow.trianglehead.counterclockwise.rotate.90")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 36))
                                    .padding(.bottom, 8)
                                
                                Text("Reset")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                            }
                        }
                        .frame(width: 48)
                        .padding(.trailing, 40)
                        
                        Abacus(beads: $beads, upperBeads: $upperBeads, counts: $counts)
                            .frame(height: 260)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func resetAbacus() {
        beads = Array(repeating: Array(repeating: false, count: 4), count: 7)
        upperBeads = Array(repeating: false, count: 7)
        counts = Array(repeating: 0, count: 7)
    }
}

#Preview {
    FreeModeScreen()
        .environment(Router())
}
