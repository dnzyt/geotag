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
    
    @StateObject var authentication = Authentication()

    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
                // HomeView
            } else {
                // Login View
               // HomeView()
                //    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                ContentView()
                   .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(authentication)
            }
        }
    }
}
