//
//  TrainingView.swift
//  geotag
//
//  Created by Ningze Dai on 11/14/22.
//

import SwiftUI

struct TrainingView: View {
    @Binding var infos: [AnswerInfo]
    @State var showQuestionSheetView: Bool = false
    @EnvironmentObject var vm: SideBarVM
    var body: some View {
        List(infos.filter({ $0.categoryId == "\(8)" })) { info in
            VStack {
                HStack() {
                    Text(info.questionLabel ?? "No value")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 20))
                        .foregroundColor(.white)
                      //  .underline()
                    
                }
                .frame(width: 700, height: 60)
                .background(.green)
                .cornerRadius(5)
                .padding(5)
                
                ForEach(info.items!.array as! [AnswerItem]) { choice in
                        if choice.ifSelected {
                            Text(choice.itemValue ?? "")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.center)
                                .font(Font.system(size: 15))
                               
                        }
                     
                    
                }
                
            }
            .onTapGesture {
                //print("Hello world")
               // QuestionSheet()
                showQuestionSheetView.toggle()
             //   vm.selectedItems = info.items
                vm.answer = info
                
            }

            

            
        }
        .sheet(isPresented: $showQuestionSheetView) {
            QuestionSheet()
                


        }
    }
}


