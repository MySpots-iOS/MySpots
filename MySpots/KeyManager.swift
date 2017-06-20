//
//  KeyManager.swift
//  MySpots
//
//  Created by Michinobu Nishimoto on 2017-06-20.
//  Copyright © 2017 ayako_sayama. All rights reserved.
//

import Foundation

struct KeyManager {
    private let keyFilePath = Bundle.main.path(forResource: "APIKey", ofType: "plist")
    
    func getKeys() -> NSDictionary? {
        guard let keyFilePath = keyFilePath else {
            return nil
        }
        return NSDictionary(contentsOfFile: keyFilePath)
    }
    
    func getValue(key: String) -> AnyObject? {
        guard let keys = getKeys() else {
            return nil
        }
        return keys[key]! as AnyObject
    }
}
