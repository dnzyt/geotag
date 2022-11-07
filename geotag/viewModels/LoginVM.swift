//
//  LoginVM.swift
//  geotag
//
//  Created by Ningze Dai on 11/6/22.
//

import Foundation

class LoginVM: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showProgressView: Bool = false
    
    var loginDisabled: Bool {
        username.isEmpty || password.isEmpty
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        LoginService.shared.login(username: username, password: password) { [unowned self] result in
            showProgressView = false
            completion(result)
        }
    }
}
