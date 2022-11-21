//
//  HomeView.swift
//  geotag
//
//  Created by Ningze Dai on 11/7/22.
//

import SwiftUI
import CoreData
import MapKit


struct ClubAnnotation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}



struct HomeView: View {
    
    @FetchRequest var clubs: FetchedResults<Club>
    @State var selectedClub: Club?
    
    @State private var showingPopover: Bool = false
    @EnvironmentObject var vm: HomeViewVM
    @State var showSheetView: Bool = false
    @State var showSideBarView: Bool = false
    
    @Environment(\.managedObjectContext) var viewContext
    
    init() {
        _clubs = FetchRequest(fetchRequest: Club.fetchRequest())
    }
    

    var body: some View {
       
        NavigationView {
            VStack {
                List {
                    ForEach(clubs, id: \.id) { club in
                        HStack {
                            VStack {
                                Image(systemName: "key")
                                    .padding(.top, 10)
                                Spacer()
                                Image(systemName: "house")
                                    .padding(.bottom,30)
                            }
                            VStack {
                                Text("Club key")
                                    .frame(width: 250, alignment: .leading)
                                Text(club.clubKey!)
                                    .frame(width: 250, alignment: .leading)
                                    .foregroundColor(.green)
                                Text("Address")
                                    .frame(width: 250, alignment: .leading)
                                Text(club.addresss!)
                                    .frame(width: 250)
                                    .foregroundColor(.green)
                            }
                            Spacer()
                            VStack {
                                Text("Club name")
                                Text(club.clubName!)
                                    .foregroundColor(.green)
                                Spacer()
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                    Image(systemName: "map.circle")
                                        .frame(width: 20, alignment: .trailing)

                                }
                            }
                        }
                    }
                }
                .sheet(item: $selectedClub) { club in
                    InfoSheetView(club: club)
                }
                .background(
                    NavigationLink("",
                                   destination: SideBarView().environmentObject(SideBarVM(c: vm.selectedClub)),
                                   isActive: $showSideBarView))
 
                Map(coordinateRegion: $vm.region, showsUserLocation: true, annotationItems: vm.annotationItems) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        PinView()
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
                    .popover(isPresented: $showingPopover, arrowEdge: .bottom) {
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
            vm.loadClubs()
        }
        
        
    }
    
    var popoverContent: some View {
        VStack {
            TextField("Club Key",text: $vm.clubID)
                    .font(Font.system(size: 20))
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 50)
                    .textFieldStyle(PlainTextFieldStyle())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
               Divider()
                .frame(width: 196)
                //.background(Color.white)
            
            TextField("Member ID", text: $vm.memberID)
                    .font(Font.system(size: 20))
                    .foregroundColor(Color.black)
                   // .background(Color.white)
                    .frame(width: 200, height: 50)
                    .textFieldStyle(PlainTextFieldStyle())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                vm.searchInfo {
                    self.showingPopover = false
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





