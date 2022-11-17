//
//  SideBarView.swift
//  geotag
//
//  Created by Ningze Dai on 11/14/22.
//

import SwiftUI

struct SideBarView: View {
    
    @EnvironmentObject var vm: SideBarVM
    
    var body: some View {
        
        NavigationView {
            List{
                NavigationLink {
                    BusinessView(infos: $vm.answerInfo)
                } label: {
                    Label("Business Method", systemImage: "bubble.left.and.bubble.right")
                }
                .padding(15)
                NavigationLink {
                    NCtrackingView(infos: $vm.answerInfo)
                } label: {
                    Label("NC Perfornamce tracking", systemImage: "bubble.left.and.bubble.right")
                }
                .padding(15)
                NavigationLink {
                    RetailView(infos: $vm.answerInfo)
                } label: {
                    Label("Retail,Recruit & Retain", systemImage: "bubble.left.and.bubble.right")
                }
                .padding(15)
                NavigationLink {
                    TrainingView(infos: $vm.answerInfo)
                } label: {
                    Label("Training", systemImage: "bubble.left.and.bubble.right")
                }
                .padding(15)
                NavigationLink {
                    AwardView(infos: $vm.answerInfo)
                } label: {
                    Label("Awards & Recognition", systemImage: "bubble.left.and.bubble.right")
                }
                .padding(15)
                NavigationLink {
                    PracticeView(infos: $vm.answerInfo)
                } label: {
                    Label("Best Practice", systemImage: "bubble.left.and.bubble.right")
                }
                .padding(15)
                NavigationLink {
                    ToolView(infos: $vm.answerInfo)
                } label: {
                    Label("supporting Tools", systemImage: "bubble.left.and.bubble.right")
                }
                .padding(15)
                NavigationLink {
                    VisitView(infos: $vm.answerInfo)
                } label: {
                    Label("Previous Visit", systemImage: "bubble.left.and.bubble.right")
                }
                .padding(15)
                
                Button {
                    
                } label: {
                    Text("Hide Menu")
                        .foregroundColor(.white)
                        .background(.blue)
                        .frame(width: 200)
                        .cornerRadius(5)
                    
                    
                }
                .padding(.top, 100)
                .padding(.leading, 50)
                
            }
            
            .listStyle(SidebarListStyle())
            .navigationTitle("Menu")
            
          Text("Please select section")
               .font(.largeTitle)
            
         //   BusinessView(infos: $vm.questionInfos)
                    }
        

        
        

        
    }
}
    


