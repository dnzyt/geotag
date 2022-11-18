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
    @StateObject var homeVM = HomeViewVM()
   // @StateObject var sideBarVM = SideBarVM()

    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
                HomeView()
                 .environment(\.managedObjectContext, persistenceController.container.viewContext)
                  .environmentObject(homeVM)
                // HomeView
            } else {
     //            Login View
//                HomeView()
//                 .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                  .environmentObject(homeVM)
               ContentView()
                 .environment(\.managedObjectContext, persistenceController.container.viewContext)
                   .environmentObject(authentication)
               // infoSheetView()
//               SideBarView()
//                   .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                   .environmentObject(sideBarVM)
            }
        }
    }
}
