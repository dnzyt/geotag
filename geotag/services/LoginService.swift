//
//  APIService.swift
//  geotag
//
//  Created by Ningze Dai on 11/6/22.
//

import Foundation


class LoginService {
    static let shared = LoginService()
    func login(username: String,
               password: String,
            completion: @escaping (Bool) -> Void
    ) {
        // Fake api call to authenticate the user
        // delay 1 second to return
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if password == "password" {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
