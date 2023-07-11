//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Matsulenko on 11.07.2023.
//

import UIKit

final class FeedViewModel {
    
    enum Action {
        case viewReady
        case buttonTapped(String)
    }
    
    enum Status {
        case initial
        case success
        case mistake
    }
    
    private let feedModel = FeedModel()
    
    var statusChanged: ((Status) -> Void)?
    
    var outputText: String = ""
    
    var outputTextColor: UIColor = .black
    
    private(set) var status: Status = .initial {
        didSet {
            statusChanged?(status)
        }
    }
    
    func changeStatus(_ action: Action) {
        switch action {
        case .viewReady:
            status = .initial
        case .buttonTapped(let word):
            switch feedModel.check(word) {
            case true:
                outputText = "Верно!"
                outputTextColor = .systemGreen
                status = .success
            case false:
                outputText = "Неверно"
                outputTextColor = .systemRed
                status = .mistake
            }
        }
    }
}
