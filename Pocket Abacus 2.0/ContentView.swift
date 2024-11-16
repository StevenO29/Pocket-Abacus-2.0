//
//  ContentView.swift
//  Pocket Abacus 2.0
//
//  Created by Steven Ongkowidjojo on 14/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var router = Router()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack(path: $router.navPath) {
                Group {
                    ZStack {
                        Color.black.ignoresSafeArea(.all)
                        
                        HStack {
                            Spacer().frame(maxWidth: geometry.size.width / 4)
                            
                            Image("mainMenuIcon")
                                .resizable()
                                .scaledToFit()
                            
                            Spacer().frame(width: 130)
                            
                            VStack {
                                Spacer().frame(height: 60)
                                
                                Image("title")
                                
                                Spacer().frame(height: 50)
                                
                                HStack(spacing: 60) {
                                    Button(
                                        action: {
                                            router.navigate(to: .freeMode)
                                        },
                                        label: {
                                            Text("Free Mode")
                                                .font(.title)
                                                .bold()
                                                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                                                .foregroundStyle(.yellow)
                                                .background(Color.white.opacity(0.45))
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                .padding(.vertical, 10)
                                                .padding(.horizontal, -50)
                                        }
                                    )
                                    
                                    Spacer().frame(width: 4)
                                    
                                    Button(
                                        action: {
                                            router.navigate(to: .relaxMode)
                                        },
                                        label: {
                                            Text("Relax Mode")
                                                .font(.title)
                                                .bold()
                                                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                                                .foregroundStyle(.yellow)
                                                .background(Color.white.opacity(0.45))
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                .padding(.vertical, 10)
                                                .padding(.horizontal, -50)
                                            
                                        }
                                    )
                                }
                            }
                            
                            Spacer().frame(maxWidth: geometry.size.width)
                        }
                    }
                }
                .navigationDestination(
                    for: Router.Destination.self,
                    destination:  { destination in
                        switch destination {
                        case .freeMode:
                            FreeModeScreen()
                        case .relaxMode:
                            RelaxModeScreen()
                        case .howToPlay:
                            HowToPlayScreen()
                        }
                    }
                )
            }
            .environment(router)
        }
    }
}

#Preview {
    ContentView()
        .environment(Router())
}
