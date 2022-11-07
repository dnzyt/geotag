//
//  UIApplication+Extension.swift
//  geotag
//
//  Created by Ningze Dai on 11/6/22.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
