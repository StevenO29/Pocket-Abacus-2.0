//
//  Pocket_Abacus_2_0App.swift
//  Pocket Abacus 2.0
//
//  Created by Steven Ongkowidjojo on 14/11/24.
//

import SwiftUI
import SwiftData

@main
struct Pocket_Abacus_2_0App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
