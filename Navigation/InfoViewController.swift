import UIKit

class InfoViewController: UIViewController {

    private lazy var readPostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Подробная информация о посте", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)

        return button
    }()

    override func viewDidLoad() {

        super.viewDidLoad()

        view.backgroundColor = .systemBackground

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

        let alert = UIAlertController(title: "Информация о посте", message: "Какую информацию о посте вы хотите узнать?", preferredStyle: .alert)

        alert.addAction(
            UIAlertAction(
                title: "Дата поста",
                style: .default,
                handler: { (_) in
                    print("Дата поста: 1 апреля 2023 г.")
                }
            )
        )

        alert.addAction(
            UIAlertAction(
                title: "Автор поста",
                style: .default,
                handler: { (_) in
                    print("Автор поста: Андрей Мацуленко")
                }
            )
        )

        present(alert, animated: true)
    }

}

