//
//  HomeViewVM.swift
//  geotag
//
//  Created by Ningze Dai on 11/7/22.
//

import Foundation
import SwiftyJSON

class HomeViewVM: ObservableObject {
    @Published var clubID = ""
    @Published var memberID = ""
    
    
    func searchInfo(completion: @escaping (JSON?) -> Void) {

        HomeService.shared.searchInfo(clubID: clubID, memberID: memberID) { json in
           completion(json)
        }
    }
    
    
    
    
    
    
    
    
    
}
        
        

        
        
    
    
