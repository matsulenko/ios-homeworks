//
//  Checker.swift
//  Navigation
//
//  Created by Matsulenko on 13.06.2023.
//

import UIKit

public final class Checker {
    
    private let login: String = "hipster"
    private let password: String = "123456"
        
    static let shared: Checker = {
        let instance = Checker()
        
        return instance
    }()
        
    init() {}
    
    public func check(enteredLogin: String?, enteredPassword: String?) -> Bool {
        if enteredLogin == login && enteredPassword == password {
            return true
        } else {
            return false
        }
    }
}
