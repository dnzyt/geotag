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
        guard let url = URL(string: Constants.url + Constants.getLabels) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(Constants.token.toBase64())", forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
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
