//
//  HomeViewVM.swift
//  geotag
//
//  Created by Ningze Dai on 11/7/22.
//

import Foundation
import SwiftyJSON
import CoreData
import MapKit

class HomeViewVM: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var clubID = ""
    @Published var memberID = ""
    @Published var clubs: [Club] = []
    @Published var annotationItems: [ClubAnnotation] = []
    
    var selectedClub: Club?
    
    private let viewContext: NSManagedObjectContext
    
    @Published var lastSeenLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 21.4765, longitude: -157.9647), latitudinalMeters: 50000, longitudinalMeters: 60000)
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        viewContext = PersistenceController.shared.container.viewContext
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func loadClubs() {
        let request = NSFetchRequest<Club>(entityName: "Club")
        do {
            let results = try viewContext.fetch(request)
            clubs.removeAll()
            annotationItems.removeAll()
            for c in results {
                clubs.append(c)
                if let geoCode = c.geoCode {
                    let arrayString = geoCode.components(separatedBy: ",")
                    let lat = Double(arrayString[0]) ?? 0
                    let lon = Double(arrayString[1]) ?? 0
                    annotationItems.append(ClubAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat),longitude: CLLocationDegrees(lon))))
                }
            }
            calculateRegion()
        } catch {
            
        }
        
    }
    
    private func calculateRegion() {
        var rect = MKMapRect(origin: MKMapPoint(CLLocationCoordinate2D(latitude: 21.4765, longitude: -157.9647)), size: MKMapSize(width: 0, height: 0))
            if let currentLocation = lastSeenLocation {
                rect = MKMapRect(origin: MKMapPoint(currentLocation.coordinate), size: MKMapSize(width: 0, height: 0))
                for annotation in annotationItems {
                    let r = MKMapRect(origin: MKMapPoint(annotation.coordinate), size: MKMapSize(width: 0, height: 0))
                    rect = rect.union(r)
                }
            } else {
                if !annotationItems.isEmpty {
                    rect = MKMapRect(origin: MKMapPoint(annotationItems[0].coordinate), size: MKMapSize(width: 0, height: 0))
                    for annotation in annotationItems {
                        let r = MKMapRect(origin: MKMapPoint(annotation.coordinate), size: MKMapSize(width: 0, height: 0))
                        rect = rect.union(r)
                    }
                }
                
            }
        var r = MKCoordinateRegion(rect)
        r.span = MKCoordinateSpan(latitudeDelta: r.span.latitudeDelta + 2, longitudeDelta: r.span.longitudeDelta + 2)
        DispatchQueue.main.async {
            self.region = r
        }
            
            
        
        
    }
    
    
    func searchInfo(dismissPopover: @escaping () -> ()) {
        
        HomeService.shared.searchInfo(
            clubID: clubID,
            memberID: memberID) { json in
                guard let json = json else { return }
                let errorMessage =  json["ErrorMessage"].stringValue
                if errorMessage == "SUCCESS" {
                    let cbs = json["GetClubDetails"].arrayValue
                    for cb in cbs {
                        let ck = cb["ClubKey"].stringValue
                        let name = cb["ClubName"].stringValue
                        let address = cb["Address"].stringValue
                        let geoCode = cb["GeoCode"].stringValue
                        
                        self.viewContext.performAndWait {
                            let c = Club(context: self.viewContext)
                            c.clubName = name
                            c.clubKey = ck
                            c.addresss = address
//                            c.geoCode = geoCode
                            c.geoCode = "37.3346,-122.0090"
                            self.clubs.append(c)
                            
                            if let geoCode = c.geoCode {
                                let arrayString = geoCode.components(separatedBy: ",")
                                let lat = Double(arrayString[0]) ?? 0
                                let lon = Double(arrayString[1]) ?? 0
                                self.annotationItems.append(ClubAnnotation(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat),longitude: CLLocationDegrees(lon))))
                            }
                        }
                    }
                    self.calculateRegion()
                    self.viewContext.perform {
                        do {
                            try self.viewContext.save()
                            print("save successfully!")
                        } catch {
                            print("save error")
                        }
                    }
                }
            }
        dismissPopover()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if lastSeenLocation == nil {
            lastSeenLocation = locations.first
            calculateRegion()
        }
        
    }
}
        
        

        
        
    
    
