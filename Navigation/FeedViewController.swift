import UIKit

class FeedViewController: UIViewController {

    private lazy var readPostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Посмотреть пост", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(readPostButton)

        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            readPostButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            readPostButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            readPostButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            readPostButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])

        readPostButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }

    @objc func buttonPressed(_ sender: UIButton) {
        let lastPost = LastPost(title: "Новый пост")

        let postViewController = PostViewController()
        postViewController.title = lastPost.title

        navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
