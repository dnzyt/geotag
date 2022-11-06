//
//  geotagApp.swift
//  geotag
//
//  Created by Ningze Dai on 11/6/22.
//

import SwiftUI

@main
struct geotagApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
