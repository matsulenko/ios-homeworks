import UIKit

class LogInViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        
        return contentView
    }()

    private lazy var vkLogoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "VkLogo")
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var loginField: TextFieldWithPadding = { [unowned self] in
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email or phone"
        textField.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        textField.textColor = .black
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.backgroundColor = .systemGray6
        
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var passwordField: TextFieldWithPadding = { [unowned self] in
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        textField.textColor = .black
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.isSecureTextEntry = true
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.backgroundColor = .systemGray6
        
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var form: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0.5
        
        stackView.layer.cornerRadius = 10.0
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.backgroundColor = .lightGray
            
        stackView.addArrangedSubview(self.loginField)
        stackView.addArrangedSubview(self.passwordField)
        
        return stackView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        
        let originalImage = UIImage(named: "BluePixel")
        let imageWhithAlpha = originalImage!.alpha(0.8)
                
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10.0
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.contentMode = .center
        button.setBackgroundImage(originalImage, for: .normal)
        button.setBackgroundImage(imageWhithAlpha, for: .highlighted)
        button.setBackgroundImage(imageWhithAlpha, for: .selected)
        button.setBackgroundImage(imageWhithAlpha, for: .disabled)
        button.layer.masksToBounds = true

        button.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
                
        return button
    }()
    
    var keyboardIsActive = false
    
    @objc
    private func openProfile(_ button: UIButton) {
        let profileViewController = ProfileViewController()

        navigationController?.pushViewController(profileViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstraints()
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        setupKeyboardObservers()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        if keyboardIsActive == false {
            scrollView.contentInset.bottom += keyboardHeight ?? 0.0
            keyboardIsActive = true
        }
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
        keyboardIsActive = false
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(vkLogoImageView)
        contentView.addSubview(form)
        contentView.addSubview(logInButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            vkLogoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            vkLogoImageView.heightAnchor.constraint(equalToConstant: 100),
            vkLogoImageView.widthAnchor.constraint(equalToConstant: 100),
            vkLogoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            form.topAnchor.constraint(equalTo: vkLogoImageView.bottomAnchor, constant: 120),
            form.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            form.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            form.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.topAnchor.constraint(equalTo: form.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}


