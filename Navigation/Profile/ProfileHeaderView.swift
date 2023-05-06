//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Matsulenko on 18.04.2023.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private let name = "Hipster Cat"
    private let status = "Waiting for something..."
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4.0
        button.layer.shadowOffset.width = 4.0
        button.layer.shadowOffset.height = 4.0
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 0.7
        button.contentMode = .center
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var avatar: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 50
        imageView.image = UIImage(named: "Markiz")
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    @objc
    private func buttonPressed() {
        print(status)
    }
    
    convenience init() {
        self.init(frame: .zero)
        nameLabel.text = name
        statusLabel.text = status
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(statusButton)
        addSubview(avatar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16.0),
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27.0),
            
            statusLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16.0),
            statusLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34.0),
            
            statusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            statusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            statusButton.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 16.0),
            statusButton.heightAnchor.constraint(equalToConstant: 50.0),
            
            avatar.widthAnchor.constraint(equalToConstant: 100.0),
            avatar.heightAnchor.constraint(equalToConstant: 100.0),
            avatar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            avatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
        ])
    }
}
