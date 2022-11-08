//
//  HomeView.swift
//  geotag
//
//  Created by Ningze Dai on 11/7/22.
//

import SwiftUI


struct HomeView: View {
    
    @State private var showingPopover: Bool = false
    @State var showList: Bool = false
    @ObservedObject var vm = HomeViewVM()
    

    var body: some View {
       
        NavigationView {
            VStack {
                if showList {
                   // Text("true")
//                    List(vm.informations) { information in
//                        VStack {
//                            HStack {
//                                Text(information.clubKey)
//                                Text(information.clubName)
//                            }
//                            Text(information.address)
//                        }
//                        
//                    }
                    
                }
                else {
                    Text("false")
                }
                
            }
                .navigationBarTitle("Nutrition club",displayMode: .inline)
                .navigationBarItems(trailing:
                  HStack {
                    Button {
                        showingPopover = true
                    } label: {
                        Image(systemName: "doc.text.magnifyingglass")
                    }
                    .popover(isPresented: $showingPopover,arrowEdge: .bottom) {
                        PopoverContent(showList: $showList)
                        
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "trash")
                    }


                    
                }
                )
                .navigationBarItems(leading:
                    Button {
                                            
                    } label: {
                      Image(systemName: "power.circle")
                    }
                
                
                )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(vm)
        
    }
}
struct PopoverContent: View {
    
    @State var clubKey: String = ""
    @State var memberID: String = ""
    @Binding var showList: Bool
    @EnvironmentObject var vm: HomeViewVM
    
    
    var body: some View {
        VStack {
            TextField("Club Key",text: $clubKey)
                    .font(Font.system(size: 20))
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 50)
                    .textFieldStyle(PlainTextFieldStyle())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
               Divider()
                .frame(width: 196)
                //.background(Color.white)
            
            TextField("Member ID", text: $memberID)
                    .font(Font.system(size: 20))
                    .foregroundColor(Color.black)
                   // .background(Color.white)
                    .frame(width: 200, height: 50)
                    .textFieldStyle(PlainTextFieldStyle())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                showList.toggle()
                
                vm.searchInfo { result in
                    print("search result: \(result)")
                }
                
            } label: {
                Text("Search")
                    .font(Font.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.orange)
                    .cornerRadius(5.0)
                    .padding(.top, 5)
            }

            
        }
        .frame(width: 250, height: 200)
        .background(Color.white)
        .cornerRadius(5)

    }
}

