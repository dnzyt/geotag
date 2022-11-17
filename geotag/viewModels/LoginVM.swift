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
        LoginService.shared.login(username: username, password: password) { [unowned self] result in
            DispatchQueue.main.async {
                completion(result)
            }
            if result {
                let qa = UserDefaults.standard.bool(forKey: "QA_DOWNLOADED")
                if !qa {
                    saveQA()
                }
                
            }
        }
    }
    
    private func saveQA() {
        LoginService.shared.fetchQA { json in
            guard let json = json else { return }
            let errorMessage =  json["ErrorMessage"].stringValue
            if errorMessage == "SUCCESS" {
                self.context.perform {
                    let questionsToHide = ["WEIGHT_LOSS_CHALLENGE_TYPE", "DAILY_CONSUMPTION_SERVE", "HEALTHY_ACTIVELF_FACILITY", "LOYALTY_PROGRAM_DTLS", "INTERNSHIP_PROGRAM_DTLS"]
                    let labels = json["Labels"].arrayValue
                    var index = 0
                    for label in labels {
                        let question = QuestionInfo(context: self.context)
                        question.categoryId = label["CategoryId"].stringValue
                        question.orderIndex = Int16(index)
                        index += 1
                        question.label = label["Label"].stringValue
                        question.questionKey = label["QuestionKey"].stringValue
                        question.questionType = label["QuestionType"].stringValue
                        question.needComment = "Y"
                        if questionsToHide.contains(question.questionKey!) {
                            question.toShow = false
                        }
                        if let items = label["Items"].array {
                            var itemIndex = 0
                            for info in items {
                                let labelKey = info["ItemKey"].stringValue
                                let labelValue = info["ItemValue"].stringValue
                                let comment = info["NeedComment"].stringValue
                                
                                let labelInfo = LabelInfo(context: self.context)
                                labelInfo.labelKey = labelKey
                                labelInfo.labelValue = labelValue
                                labelInfo.needComment = comment
                                
                                question.insertIntoItems(labelInfo, at: itemIndex)
                                itemIndex += 1
//                                labelInfo.question = question
                                
                               // print("\(question)")
                            }
                        }
                    }
                    do {
                        try self.context.save()
                        UserDefaults.standard.set(true, forKey: "QA_DOWNLOADED")
                        print("save successfully!")
                    } catch {
                        print("save error")
                    }
                }
            }

        }
    }
    
    
}
