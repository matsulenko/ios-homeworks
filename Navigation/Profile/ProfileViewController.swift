import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        return profileHeaderView
    }()
    
//    private lazy var readPostButton: UIButton = {
//        let button = UIButton()
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.setTitle("Посмотреть пост", for: .normal)
//            button.setTitleColor(.systemRed, for: .normal)
//
//            return button
//        }()
    
    private lazy var donateMoneyButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Donate $1,000", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        
        button.contentMode = .center
        
        button.backgroundColor = .systemBlue

        button.addTarget(self, action: #selector(donateMoney), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func donateMoney() {
        print("You have donated $1,000")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstraints()
        
        title = "Профиль"
        view.backgroundColor = .systemGray4
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
                
    }

    private func addSubviews() {
        view.addSubview(profileHeaderView)
        view.addSubview(donateMoneyButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            donateMoneyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            donateMoneyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            donateMoneyButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            donateMoneyButton.heightAnchor.constraint(equalToConstant: 50.0),
        ])
    }
}

