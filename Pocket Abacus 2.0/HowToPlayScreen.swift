//
//  HowToPlayScreen.swift
//  Pocket Abacus 2.0
//
//  Created by Steven Ongkowidjojo on 15/11/24.
//

import SwiftUI

struct HowToPlayScreen: View {
    
    @Environment(Router.self) private var router
    @State private var currentHint = 0 // 0: hint, 1: hint1, 2: hint2
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea(.all)
                
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: 300)
                        
                        Text(currentHint == 0 ? "Counting" : currentHint == 1 ? "Big Friends" : "Small Friends")
                            .foregroundColor(.yellow)
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        Button(action: {
                            router.navigateBack()
                        }) {
                            Image(systemName: "x.circle.fill")
                                .foregroundStyle(.white)
                                .opacity(0.45)
                                .font(.system(size: 40))
                        }
                        .padding(.top, 20)
                        .padding(.trailing, 20)
                    }
                    .frame(height: 100)
                    
                    Spacer()
                    
                    // Hint image with chevron buttons
                    HStack {
                        // Chevron left button (visible only if currentHint > 0)
                        if currentHint > 0 {
                            Button(action: {
                                currentHint -= 1
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                            }
                            .padding(.leading, 12)
                        } else {
                            Spacer()
                        }
                        
                        Spacer()
                        
                        // Hint image
                        Image(currentHint == 0 ? "hint" : currentHint == 1 ? "hint1" : "hint2")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 300) // Adjust the frame as needed to center vertically
                        
                        Spacer()
                        
                        // Chevron right button (visible only if currentHint < 2)
                        if currentHint < 2 {
                            Button(action: {
                                currentHint += 1
                            }) {
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                            }
                            .padding(.trailing, 12)
                        } else {
                            Spacer()
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HowToPlayScreen()
        .environment(Router())
}
