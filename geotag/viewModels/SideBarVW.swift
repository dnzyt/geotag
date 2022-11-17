//
//  SideBarVW.swift
//  geotag
//
//  Created by Ningze Dai on 11/14/22.
//

import Foundation
import CoreData
import SwiftUI

class SideBarVM: NSObject, ObservableObject {
    
   // @Published var questionInfos: [QuestionInfo] = []
   // @Published var selectedQuestion: QuestionInfo?
    
    @Published var answerInfo: [AnswerInfo] = []
    @Published var answer: AnswerInfo?
    
    @Published var answerItems: [AnswerItem] = []
    @Published var answerItem: AnswerItem?
   // @Published var ifSelected: Bool = false
    
    var selectedClub: Club?
    
    
    
    private let viewContext: NSManagedObjectContext
    
    
    init(c: Club?) {
        if c == nil {
            print("selected club nil")
        }
        selectedClub = c
        viewContext = PersistenceController.shared.container.viewContext
        super.init()
       // fetchQuestionInfo()
        prepareAnswerInfo()
        
    }
    
//    func fetchQuestionInfo() {
//       let request = NSFetchRequest<QuestionInfo>(entityName: "QuestionInfo")
//        request.sortDescriptors = [NSSortDescriptor(key: "orderIndex", ascending: true)]
//
//        do {
//            let results = try viewContext.fetch(request)
//
//
//            questionInfos.removeAll()
//            for info in results {
//
//                questionInfos.append(info)
//            }
//
//
//        } catch {
//            print("fetch failed")
//        }
//
//    }
    
    func prepareAnswerInfo() {
        let request = NSFetchRequest<QuestionInfo>(entityName: "QuestionInfo")
        request.sortDescriptors = [NSSortDescriptor(key: "orderIndex", ascending: true)]
        
        do {
            let results = try viewContext.fetch(request)
            for info in results {
                let answer = AnswerInfo(context: self.viewContext)
                answer.questionKey = info.questionKey
                answer.questionLabel = info.label
                answer.clubKey = selectedClub?.clubKey
                answer.categoryId = info.categoryId
                
                if let items = info.items {
                    var itemIndex = 0
                    for ite in items {
                        let temp = ite as! LabelInfo
                        let ansitem = AnswerItem(context: self.viewContext)
                        ansitem.itemKey = temp.labelKey
                        ansitem.itemValue = temp.labelValue
                        ansitem.needComment = temp.needComment
                        ansitem.ifSelected = false
                        ansitem.answerInfo = answer
                        itemIndex += 1
                        
                    }
                }
                answerInfo.append(answer)
            }
            
            try viewContext.save()
            
            
            
        } catch {
            print("fetch failed")
        }
    }
    
    
}
