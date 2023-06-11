//
//  User.swift
//  Navigation
//
//  Created by Matsulenko on 09.06.2023.
//

import UIKit

protocol UserService {
    
    var user: User { get }
    
    func userCheck(login: String) -> User?
    
}

class User {
    
    let login: String
    var fullName: String
    var avatar: UIImage
    var status: String?
    
    init(login: String, fullName: String, avatar: UIImage, status: String? = nil) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
    
}

class CurrentUserService: UserService {
    
    let user = User(
        login: "hipster",
        fullName: "Hipster Cat",
        avatar: UIImage(named: "Markiz")!,
        status: "Waiting for something..."
    )
    
    func userCheck(login: String) -> User? {
        if user.login == login {
            return user
        } else {
            return nil
        }
    }
}

class TestUserService: UserService {
    
    let user = User(
        login: "test",
        fullName: "Tester",
        avatar: UIImage(named: "cats17")!,
        status: "Let's test it!"
    )
    
    func userCheck(login: String) -> User? {
        if user.login == login {
            return user
        } else {
            return nil
        }
    }
    
}
