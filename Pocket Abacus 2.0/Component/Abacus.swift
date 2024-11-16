//
//  Abacus.swift
//  Pocket Abacus 2.0
//
//  Created by Steven Ongkowidjojo on 16/11/24.
//

import SwiftUI

struct Abacus: View {
    @Binding var beads: [[Bool]]
    @Binding var upperBeads: [Bool]
    @Binding var counts: [Int]
    
    var body: some View {
        ZStack {
            HStack(spacing: 76) {
                ForEach(0..<7) { _ in
                    Image("poleAbacus")
                        .resizable()
                        .frame(width: 8, height: 260)
                }
            }
            
            Image("frameAbacus")
                .resizable()
            
            VStack {
                Spacer().frame(height: 16)
                
                // Upper beads (heaven beads)
                HStack(spacing: 24) {
                    ForEach(0..<7) { index in
                        VStack {
                            if upperBeads[index] {
                                Spacer()
                            }
                            
                            Image(upperBeads[index] ? "beadsOn" : "beadsOff")
                                .resizable()
                                .frame(width: 60, height: 28)
                                .offset(y: upperBeads[index] ? +36 : 0)
                                .animation(.easeInOut, value: upperBeads[index])
                                .onTapGesture {
                                    upperBeads[index].toggle()
                                    updateCount(for: index)
                                }
                            
                            if !upperBeads[index] {
                                Spacer()
                            }
                        }
                    }
                }
                .frame(height: 24)
                
                // Lower beads (earth beads)
                HStack(spacing: 24) {
                    ForEach(0..<7) { columnIndex in
                        VStack(spacing: 2) {
                            Spacer()
                            ForEach(0..<4) { beadIndex in
                                Image(beads[columnIndex][beadIndex] ? "beadsOn" : "beadsOff")
                                    .resizable()
                                    .frame(width: 60, height: 28)
                                    .offset(y: beads[columnIndex][beadIndex] ? -52 + CGFloat(getOffset(for: columnIndex, beadIndex: beadIndex)) : 0)
                                    .animation(.easeInOut, value: beads[columnIndex][beadIndex])
                                    .onTapGesture {
                                        toggleBead(column: columnIndex, bead: beadIndex)
                                        updateCount(for: columnIndex)
                                    }
                            }
                            Spacer().frame(height: 10)
                        }
                    }
                }
                .frame(height: 232)
            }
        }
    }
    
    private func toggleBead(column: Int, bead: Int) {
        if beads[column][bead] {
            // Turunkan semua manik-manik di bawahnya
            for i in bead..<4 {
                beads[column][i] = false
            }
        } else {
            // Angkat semua manik-manik di atasnya
            for i in 0...bead {
                beads[column][i] = true
            }
        }
    }
    
    private func updateCount(for column: Int) {
        let lowerBeadsCount = beads[column].filter { $0 }.count
        let upperBeadsCount = upperBeads[column] ? 5 : 0
        counts[column] = lowerBeadsCount + upperBeadsCount
    }
    
    private func getOffset(for column: Int, beadIndex: Int) -> Int {
        // Menghitung berapa banyak manik-manik yang ada di atas beadIndex yang sudah diangkat
        var count = 0
        for i in 0...beadIndex {
            if beads[column][i] {
                count += 1
            }
        }
        return count
    }
}
