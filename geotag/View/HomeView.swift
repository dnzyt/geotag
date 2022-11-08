//
//  HomeView.swift
//  geotag
//
//  Created by Ningze Dai on 11/7/22.
//

import SwiftUI
import CoreData


struct HomeView: View {
    @State var clubKey: String = ""
    @State var memberID: String = ""
    @State private var showingPopover: Bool = false
    @ObservedObject var vm = HomeViewVM()
    @State var clubs: [Club] = []
    
    @Environment(\.managedObjectContext) var viewContext
    

    var body: some View {
       
        NavigationView {
            VStack {
                    List {
                        ForEach(clubs) { club in
                            Text(club.clubKey!)
                        }
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
                        popoverContent
                        
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
        .onAppear {
            do {
                let request = NSFetchRequest<Club>(entityName: "Club")
                let results = try viewContext.fetch(request)
                for c in results {
                    clubs.append(c)

                }
                
            } catch {
                print("fetch clubs failed.")
            }
            
        }
        
    }
    
    var popoverContent: some View {
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
                
                vm.searchInfo { json in
                    guard let json = json else { return }
                    let errorMessage =  json["ErrorMessage"].stringValue
                    if errorMessage == "SUCCESS" {
                        let cbs = json["GetClubDetails"].arrayValue
                        for cb in cbs {
                            let ck = cb["ClubKey"].stringValue
                            let name = cb["ClubName"].stringValue
                            let address = cb["Address"].stringValue
                            
                            viewContext.perform {
                                let c = Club(entity: Club.entity(), insertInto: viewContext)
                                c.clubName = name
                                c.clubKey = ck
                                c.addresss = address
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





