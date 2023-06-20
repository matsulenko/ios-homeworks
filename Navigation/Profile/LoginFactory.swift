//
//  LoginFactory.swift
//  Navigation
//
//  Created by Matsulenko on 13.06.2023.
//

import UIKit

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
