//
//  HomeView.swift
//  geotag
//
//  Created by Ningze Dai on 11/7/22.
//

import SwiftUI
import CoreData
import MapKit

struct MyAnnotationItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}



struct HomeView: View {
    @State var clubKey: String = ""
    @State var memberID: String = ""
    @State private var showingPopover: Bool = false
    @ObservedObject var vm = HomeViewVM()
    @State var clubs: [Club] = []
    @State var showSheetView: Bool = false
//    @State var coordinateRegion: MKCoordinateRegion = {
//        var newRegion = MKCoordinateRegion()
//        newRegion.center.latitude = -6.270598386958833
//        newRegion.center.longitude = 106.53145176654043
//        newRegion.span.latitudeDelta = 0.1
//        newRegion.span.longitudeDelta = 0.1
//        return newRegion
//    }()
    
    @StateObject var locationManager = LocationManager()
     
    
    @State var annotationItems: [MyAnnotationItem] = [
       // MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 37.78, longitude: -122.44)),
      //  MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: -6.270598386958833, longitude: 106.53145176654043))
                
    ]
    @State var clubIndex: Int = 0
    
   
    
    
    
    @Environment(\.managedObjectContext) var viewContext
    

    var body: some View {
       
        NavigationView {
            VStack {

            List(clubs) { club in
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
                .onTapGesture {
                    showSheetView.toggle()
                    let tapIndex = clubs.firstIndex(of: club)
                    clubIndex = tapIndex ?? 0
                }
               
            
            }
            .sheet(isPresented: $showSheetView) {
                infoSheetView(clubIndex: $clubIndex, clubs: $clubs)
                    .environmentObject(locationManager)
            }
                        
            
               //Map(coordinateRegion: mapRegion)
             //   ForEach(clubs, id: \.self) { club in
               //     geoCode = club.geoCode?.components(separatedBy: ",") as! [Float]
                 //   let lat = geoCode[0]
                   // let lont = geoCode[1]
               // }
                Map(coordinateRegion: $locationManager.region, showsUserLocation: true,  annotationItems: annotationItems) { item in
                  //  MapPin(coordinate: item.coordinate)
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
                        
                   // print("\(c.geoCode)")
                       
                       
                    let arrayString = c.geoCode?.split(separator: ",")
                    var arrayDouble = arrayString?.compactMap(Double.init)
                    if arrayDouble == nil {
                        arrayDouble = [-6.270598386958833, 106.53145176654043]
                    }
                    else {
                        let lat = arrayDouble?[0]
                        let longt = arrayDouble?[1]
                        annotationItems.append(MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat!), longitude: CLLocationDegrees(longt!))))
                        print("\(annotationItems)")
                    }
                        
                    
                    
                    
                    
                    
                    
                }
            }
                catch {
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





