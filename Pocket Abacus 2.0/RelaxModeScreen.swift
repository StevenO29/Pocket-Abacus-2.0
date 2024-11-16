//
//  RelaxModeScreen.swift
//  Pocket Abacus 2.0
//
//  Created by Steven Ongkowidjojo on 15/11/24.
//

import SwiftUI

struct RelaxModeScreen: View {
    @Environment(Router.self) private var router
    
    @State private var firstNumber: Int = 0
    @State private var secondNumber: Int = 0
    @State private var numberOperator: String = ""
    @State private var answer: Int = 0
    @State private var correctAnswer: Int = 0
    @State private var beads: [[Bool]] = Array(repeating: Array(repeating: false, count: 4), count: 7)
    @State private var upperBeads: [Bool] = Array(repeating: false, count: 7)
    @State private var counts: [Int] = Array(repeating: 0, count: 7)
    @State private var showCorrectPopup: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        HStack {
                            Button(action: {
                                router.navigateBack()
                            }) {
                                Image(systemName: "arrow.left")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40))
                            }
                            
                            Spacer()
                            
                            Text("\(firstNumber) \(numberOperator) \(secondNumber) = \(answer)")
                                .foregroundStyle(.yellow)
                                .font(.title)
                                .bold()
                            
                            Spacer()
                            
                            Button(action: {
                                router.navigate(to: .howToPlay)
                            }) {
                                Image(systemName: "questionmark.circle.fill")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40))
                            }
                        }
                        
                        Spacer()
                        
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
                    .disabled(showCorrectPopup)
                    .padding()
                    .overlay(
                        Group {
                            if showCorrectPopup {
                                ZStack {
                                    Rectangle()
                                        .foregroundStyle(.black)
                                        .ignoresSafeArea(.all)
                                        .opacity(0.5)
                                    VStack {
                                        Image("correct")
                                            .resizable()
                                            .scaledToFit()
                                        Text("Continue...")
                                            .foregroundStyle(.white)
                                    }
                                }
                                .onTapGesture {
                                    showCorrectPopup = false
                                    resetAbacus()
                                }
                            }
                        }
                    )
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                generateRandomOperation()
                answer = 0 // Ensure answer is 0 initially
            }
            .onChange(of: counts, initial: true) { oldCounts, newCounts in
                calculateAnswer()
                if answer == correctAnswer {
                    showCorrectPopup = true
                }
            }
        }
    }
    
    private func generateRandomOperation() {
        // Randomize firstNumber and numberOperator
        firstNumber = Int.random(in: 1...999)
        
        let operators = ["+", "-"]
        numberOperator = operators.randomElement() ?? "+"
        
        repeat {
            // Randomize secondNumber based on the operator
            switch numberOperator {
            case "+":
                secondNumber = Int.random(in: 1...999)
                correctAnswer = firstNumber + secondNumber
            case "-":
                secondNumber = Int.random(in: 1...firstNumber) // Ensure result is non-negative
                correctAnswer = firstNumber - secondNumber
            default:
                secondNumber = 0
            }
        } while correctAnswer > 9_999_999 // Ensure answer does not exceed 9,999,999
    }
    
    private func resetAbacus() {
        beads = Array(repeating: Array(repeating: false, count: 4), count: 7)
        upperBeads = Array(repeating: false, count: 7)
        counts = Array(repeating: 0, count: 7)
        answer = 0
        generateRandomOperation()
        showCorrectPopup = false
    }
    
    private func calculateAnswer() {
        var total = 0
        let multipliers = [1_000_000, 100_000, 10_000, 1_000, 100, 10, 1]
        for i in 0..<counts.count {
            total += counts[i] * multipliers[i]
        }
        answer = total
    }
}

#Preview {
    RelaxModeScreen()
        .environment(Router())
}
