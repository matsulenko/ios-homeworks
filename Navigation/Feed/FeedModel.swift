//
//  FeedModel.swift
//  Navigation
//
//  Created by Matsulenko on 26.06.2023.
//

import UIKit

protocol FeedModelDelegate {
    func check(word: String) -> Bool
}

public final class FeedModel: FeedModelDelegate {
    private let secretWord = "Шумахер"
    
    func check(word: String) -> Bool {
        if word == secretWord {
            return true
        } else {
            return false
        }
    }
}
