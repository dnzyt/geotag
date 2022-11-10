//
//  QAService.swift
//  geotag
//
//  Created by Ningze Dai on 11/10/22.
//

import Foundation
import SwiftyJSON

class QAService {
    static let shared = QAService()
    func fetchQA(username: String,
               password: String,
            completion: @escaping (JSON?) -> Void
    ) {
        var dict = [String: String]()
        dict["CountryCode"] = "ID"
        guard let url = URL(string: "https://herbalife-oegdevws.hrbl.com/Distributor/NClubGeoTrackRS_prs/NClubGetLabelDetails") else { return }
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
                completion(json)
            } else {
                completion(json)
            }
        }.resume()
    }
    
    
}
