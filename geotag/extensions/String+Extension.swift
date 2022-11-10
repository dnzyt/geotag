//
//  String+Extension.swift
//  geotag
//
//  Created by Ningze Dai on 11/10/22.
//

import Foundation

extension String {
    func localized(forLanguageCode langCode: String) -> String {
        guard let bundlePath = Bundle.main.path(forResource: langCode, ofType: "lproj"),
              let bundle = Bundle(path: bundlePath)
        else {
            return ""
        }
        
        return NSLocalizedString(self, bundle: bundle, value: "", comment: "")
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
