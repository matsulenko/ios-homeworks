import UIKit

class ProfileTableHederView: UIView {
    
    @IBAction func done(_ sender: TextFieldWithPadding) {
        sender.resignFirstResponder()
    }
    
    private let name = "Hipster Cat"
    private var status: String? = "Waiting for something..."
    
    private lazy var fullNameLabel: UILabel = {
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
    
    private lazy var statusTextField: TextFieldWithPadding = { [unowned self] in
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter text here"
        textField.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        textField.textColor = .black
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(buttonPressed), for: .editingDidEndOnExit)

        return textField
        
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4.0
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 0.7
        button.setTitle("Set status", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.contentMode = .center
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var avatarImageView: UIImageView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func statusTextChanged(_ textField: UITextField) {
        status = textField.text
    }
    
    @objc
    private func buttonPressed() {
        statusLabel.text = status
        self.endEditing(true)
    }
    
    private func setupView() {
        fullNameLabel.text = name
        statusLabel.text = status
        backgroundColor = .systemGray6
    }

    private func addSubviews() {
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(avatarImageView)
        addSubview(statusTextField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16.0),
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27.0),
            
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16.0),
            statusLabel.bottomAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 30.0),
            
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16.0),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50.0),
            
            avatarImageView.widthAnchor.constraint(equalToConstant: 100.0),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100.0),
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            
            statusTextField.heightAnchor.constraint(equalToConstant: 40.0),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16.0),
            statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16.0),
            
            self.bottomAnchor.constraint(equalTo: setStatusButton.bottomAnchor, constant: 16.0)
        ])
    }
}
