//
//  Authentication.swift
//  geotag
//
//  Created by Ningze Dai on 11/6/22.
//

import Foundation
import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated = false
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
}
