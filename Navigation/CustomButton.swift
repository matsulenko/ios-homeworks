//
//  CustomButton.swift
//  Navigation
//
//  Created by Matsulenko on 22.06.2023.
//

import UIKit

public final class CustomButton: UIButton {
    var buttonAction: (() -> Void)?
    
    init(
        title: String,
        titleColor: UIColor,
        hasBackgroundImage: Bool,
        hasShadow: Bool,
        titleFontSize: Double?,
        cornerRadius: Double?,
        backgroundColor: UIColor?,
        buttonAction: (() -> Void)?
    ) {
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .center
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        
        if titleFontSize != nil {
            titleLabel?.font = UIFont.systemFont(ofSize: titleFontSize!, weight: .regular)
        }
        
        if cornerRadius != nil {
            layer.cornerRadius = cornerRadius!
        }
        
        if backgroundColor != nil {
            self.backgroundColor = backgroundColor
        }
        
        if hasBackgroundImage {
            let originalImage = UIImage(named: "BluePixel")
            let imageWhithAlpha = originalImage!.alpha(0.8)
                            
            setBackgroundImage(originalImage, for: .normal)
            setBackgroundImage(imageWhithAlpha, for: .highlighted)
            setBackgroundImage(imageWhithAlpha, for: .selected)
            setBackgroundImage(imageWhithAlpha, for: .disabled)
            layer.masksToBounds = true
        }
        
        if hasShadow {
            layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
            layer.shadowRadius = 4.0
            layer.shadowOpacity = 0.7
        }
        
        self.buttonAction = buttonAction
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
}
