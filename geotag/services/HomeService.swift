//
//  HomeService.swift
//  geotag
//
//  Created by Ningze Dai on 11/8/22.
//

import Foundation
import SwiftyJSON

class HomeService {
    static let shared = HomeService()
    func searchInfo(clubID: String,
               memberID: String,
            completion: @escaping (JSON?) -> Void
    ) {
        var dict = [String: String]()
        dict["Distributorld"] = ""
        dict["ClubKey"] = "1090134"
        guard let url = URL(string: "https://herbalife-oegdevws.hrbl.com/Distributor/NClubGeoTrackRS_prs/NClubGetClubDetails") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Basic TkNHZW9UcmFja1Rlc3Q6TkNHMFRyQGNrVGVzdCFuZw==", forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                // error happens
                
                return
            }
            
            let json = try! JSON(data: data!)
            print("json: \(json)")
            if let _ = json["errorMessage"].string {
                completion(nil)
            } else {
                completion(json)
            }
        }.resume()
    }
    
    
}
