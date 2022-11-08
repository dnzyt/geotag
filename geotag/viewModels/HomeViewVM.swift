//
//  HomeViewVM.swift
//  geotag
//
//  Created by Ningze Dai on 11/7/22.
//

import Foundation
import SwiftyJSON

class HomeViewVM: ObservableObject {
    @Published var informations = [Location]()
    @Published var clubID = ""
    @Published var memberID = ""
    
    func searchInfo(completion: @escaping (Bool) -> Void) {

        HomeService.shared.searchInfo(clubID: clubID, memberID: memberID)
            { [unowned self] result in
                DispatchQueue.main.async {
                   // showProgressView = false
                    
                completion(result)
                }
        }
    }
    
    
    
    
    
    
    
}
        
        

        
        
    
    
