//
//  APIService.swift
//  geotag
//
//  Created by Ningze Dai on 11/6/22.
//

import Foundation
import SwiftyJSON


class LoginService {
    static let shared = LoginService()
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        var dict = [String: String]()
        dict["userName"] = "ningzeda"
        dict["password"] = "well3210#@!)26"
        guard let url = URL(string: "https://herbalife-econnectslc.hrbl.com:8443/CommonServices/rest/login/ldapLogin") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error { return }
            
            let json = try! JSON(data: data!)
            print("json: \(json)")
            if let _ = json["errorMessage"].string {
                completion(false)
            } else {
                completion(true)
            }
        }.resume()
    }
    
    func fetchQA(completion: @escaping (JSON?) -> Void) {
        var dict = [String: String]()
        dict["CountryCode"] = "ID"
        guard let url = URL(string: Constants.url + Constants.getLabels) else { return }
        print("\(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(Constants.token.toBase64())", forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: dict, options: []) else { return }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error { return }
            
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
