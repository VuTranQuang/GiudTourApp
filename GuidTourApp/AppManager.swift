//
//  AppManager.swift
//  GuidTourApp
//
//  Created by Vu on 06/01/2021.
//

import Foundation

enum AppManager {
     static func setUserSeenAppInstruction() {
        UserDefaults.standard.set(true, forKey: "userSeenShowCase")
    }
    
    static func getUserSeenAppInstruction() -> Bool {
        let userSeenShowCaseOnject = UserDefaults.standard.object(forKey: "userSeenShowCase")
        
        if let userSeenShowCase = userSeenShowCaseOnject as? Bool {
            return userSeenShowCase
        }
        return false
    }
}
