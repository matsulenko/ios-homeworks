//
//  FeedModel.swift
//  Navigation
//
//  Created by Matsulenko on 26.06.2023.
//

import UIKit

public final class FeedModel {
    private let secretWord = "Шумахер"
    
    func check(_ word: String) -> Bool {
        if word == secretWord {
            return true
        } else {
            return false
        }
    }
}
