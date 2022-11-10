//
//  LoginVM.swift
//  geotag
//
//  Created by Ningze Dai on 11/6/22.
//

import Foundation
import SwiftyJSON
import CoreData

class LoginVM: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    let context: NSManagedObjectContext
    
    init() {
        context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = PersistenceController.shared.container.persistentStoreCoordinator
    }
    
    
    
    var loginDisabled: Bool {
        username.isEmpty || password.isEmpty
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        LoginService.shared.login(
            username: username,
            password: password) { result in
                DispatchQueue.main.async {
                    completion(result)
                }
        }
    }
    
    func saveQA(completion: @escaping (JSON?) -> Void) {
        QAService.shared.fetchQA(username: username, password: password) { json in
            guard let json = json else { return }
            let errorMessage =  json["ErrorMessage"].stringValue
            if errorMessage == "SUCCESS" {
                self.context.perform {
                    let labels = json["Labels"].arrayValue
                    for label in labels {
                        let infos = label["Items"].arrayValue
                        
                        for info in infos {
                            let labelKey = info["ItemKey"].stringValue
                            let labelValue = info["ItemValue"].stringValue
                            let comment = info["NeedComment"].stringValue
                            
                            let labelInfo = LabelInfo(entity: LabelInfo.entity(), insertInto: self.context)
                            labelInfo.labelKey = labelKey
                            labelInfo.labelValue = labelValue
                            labelInfo.needComment = comment
                        }
                    }
                    do {
                        try self.context.save()
                        print("save successfully!")
                    } catch {
                        print("save error")
                    }
                }
            }

        }
    }
    
    
}

/*
 vm.searchInfo { json in
     guard let json = json else { return }
     let errorMessage =  json["ErrorMessage"].stringValue
     if errorMessage == "SUCCESS" {
         let cbs = json["GetClubDetails"].arrayValue
         for cb in cbs {
             let ck = cb["ClubKey"].stringValue
             let name = cb["ClubName"].stringValue
             let address = cb["Address"].stringValue
             let geoCode = cb["GeoCode"].stringValue
             
             viewContext.perform {
                 let c = Club(entity: Club.entity(), insertInto: viewContext)
                 c.clubName = name
                 c.clubKey = ck
                 c.addresss = address
                 c.geoCode = geoCode
                 clubs.append(c)
                 
                 do {
                     try viewContext.save()
                     print("save successfully!")
                 } catch {
                     print("save error")
                 }
                 
             }
         }
     }
 }
 */
