//
//  QuestionSheet.swift
//  geotag
//
//  Created by Ningze Dai on 11/15/22.
//

import SwiftUI

struct QuestionSheet: View {
    
    @EnvironmentObject var vm: SideBarVM
    @State var text: String = ""
    @State var selection = Set<AnswerItem>()

    var body: some View {
        NavigationView {
                VStack {
                    Text(vm.answer?.questionLabel ?? "No questions")
                        .font(.title2)
                        .font(Font.system(size: 30))
                        .padding(.bottom, 15)
                    
                    List(vm.answer?.items?.array as! [AnswerItem], id: \.self, selection: $selection) { ansItem in
                        Text(ansItem.itemValue!)
                            .font(Font.system(size: 20))
                            .padding(5)

                    }
                    .frame(width: 600, height: 400)
                    .border(.green)
                    .toolbar {
                        EditButton()
                    }
                    
//                    VStack (alignment: .leading) {
//
//                        ForEach(items) { item in
//                            Text(item.labelValue!)
//                                .font(Font.system(size: 20))
//                                .padding(5)
//
//
//
//
//                        }
//                    }
//                    .frame(width: 400)
//                    .border(.green)
//                    .padding(.leading, 120)
                    TextField("leave comment...", text: $text)
                        .multilineTextAlignment(.leading)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minWidth: 100, maxWidth: 600, minHeight: 100, maxHeight: 200, alignment: .topLeading)
                        .border(.green)
                       // .padding(.leading, 20)
                    HStack {
                        Spacer()
                        Button {
                            for i in selection {
                                i.ifSelected = true
                            }
                            
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .font(Font.system(size: 50))
                        }
                        Spacer()

                    }
                }
                

            
            
                
            }
    }
}


