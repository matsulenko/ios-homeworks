import UIKit

final class FeedViewController: UIViewController {
    
    private var typedWord: String?
    private var savedWord: String?
    
    private lazy var checkGuessTextField: TextFieldWithPadding = { [unowned self] in
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Угадай слово"
        textField.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        textField.textColor = .black
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 12.0
//        textField.layer.borderWidth = 1.0
        textField.addTarget(self, action: #selector(typedWordChanged), for: .editingChanged)
        
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var checkGuessButton = CustomButton(
        title: "Проверить",
        titleColor: .white,
        hasBackgroundImage: false,
        hasShadow: false,
        titleFontSize: nil,
        cornerRadius: 4.0,
        backgroundColor: .systemBlue
    ) { [self] in
        savedWord = typedWord
        if feedModelDelegate.check(word: savedWord ?? "") {
            checkLabel.text = "Верно!"
            checkLabel.textColor = .systemGreen
        } else {
            checkLabel.text = "Неверно"
            checkLabel.textColor = .systemRed
        }
    }

    private lazy var readPostButton = CustomButton(
        title: "Посмотреть пост",
        titleColor: .systemRed,
        hasBackgroundImage: false,
        hasShadow: false,
        titleFontSize: nil,
        cornerRadius: nil,
        backgroundColor: nil
    ) { [self] in
        let lastPost = LastPost(title: "Новый пост")

        let postViewController = PostViewController()
        postViewController.title = lastPost.title

        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private var feedModelDelegate: FeedModelDelegate
    
    private var checkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    init(feedModelDelegate: FeedModelDelegate) {
        self.feedModelDelegate = feedModelDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func typedWordChanged(_ textField: UITextField) {
        typedWord = textField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstraints()
        setDefaultValues()
    }
    
    private func addSubviews() {
        view.addSubview(readPostButton)
        view.addSubview(checkGuessTextField)
        view.addSubview(checkGuessButton)
        view.addSubview(checkLabel)
    }
    
    private func setDefaultValues() {
        savedWord = "Шумахер"
        typedWord = savedWord
        checkGuessTextField.text = savedWord
    }
    
    private func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            checkGuessTextField.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            
            checkGuessTextField.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            
            checkGuessTextField.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            
            checkGuessButton.leadingAnchor.constraint(
                equalTo: checkGuessTextField.leadingAnchor
            ),
            
            checkGuessButton.trailingAnchor.constraint(
                equalTo: checkGuessTextField.trailingAnchor
            ),
            
            checkGuessButton.topAnchor.constraint(
                equalTo: checkGuessTextField.bottomAnchor,
                constant: 20
            ),
            
            checkLabel.leadingAnchor.constraint(
                equalTo: checkGuessTextField.leadingAnchor
            ),
            
            checkLabel.trailingAnchor.constraint(
                equalTo: checkGuessTextField.trailingAnchor
            ),
            
            checkLabel.topAnchor.constraint(
                equalTo: checkGuessButton.bottomAnchor,
                constant: 20
            ),
            
            readPostButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            readPostButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            readPostButton.centerYAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerYAnchor
            ),
            readPostButton.heightAnchor.constraint(
                equalToConstant: 44.0
            )
        ])
    }
}

extension FeedViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
