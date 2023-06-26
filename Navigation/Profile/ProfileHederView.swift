import UIKit

class ProfileHederView: UIView {
    
//    private let name = "Hipster Cat"
    private var status: String?
//    
    var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    var statusLabel: UILabel = {
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
        textField.addTarget(self, action: #selector(edited), for: .editingDidEndOnExit)

        return textField
    }()
    
    private lazy var setStatusButton = CustomButton(
        title: "Set status",
        titleColor: .white,
        hasBackgroundImage: false,
        hasShadow: true,
        titleFontSize: 18.0,
        cornerRadius: 4.0,
        backgroundColor: .systemBlue
    ) { [self] in
        self.statusLabel.text = self.status
        self.endEditing(true)
    }
    
    var avatarImageView: UIImageView = {
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
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0
        
        return view
    }()
    
    private lazy var xMark: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "xmark")
        imageView.tintColor = .white
        imageView.alpha = 0
        
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
    
    func done(_ sender: TextFieldWithPadding) {
        sender.resignFirstResponder()
    }
    
    @objc
    private func statusTextChanged(_ textField: UITextField) {
        status = textField.text
    }
    
    @objc
    private func launchAnimationExample() {
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
 
        }

        avatarImageView.isUserInteractionEnabled = false
        
        let duration = 0.5
        
        let avatarAnimationPosition = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        avatarAnimationPosition.toValue = CGPoint(
            x: setStatusButton.center.x,
            y: xMark.bounds.minY + whiteView.bounds.width/2
            )
        avatarAnimationPosition.duration = duration
        avatarAnimationPosition.autoreverses = false
        avatarAnimationPosition.isRemovedOnCompletion = false
        avatarAnimationPosition.fillMode = .forwards
        avatarAnimationPosition.delegate = self
        self.layer.zPosition = 1

        let growthAnimation = CABasicAnimation(keyPath: "transform.scale")
        growthAnimation.toValue = whiteView.bounds.width / avatarImageView.bounds.width
        growthAnimation.fillMode = .forwards
        growthAnimation.isRemovedOnCompletion = false
        growthAnimation.duration = duration
        
        let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadiusAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        cornerRadiusAnimation.fromValue = 50
        cornerRadiusAnimation.toValue = 0
        cornerRadiusAnimation.duration = duration
        cornerRadiusAnimation.isRemovedOnCompletion = false
        cornerRadiusAnimation.fillMode = .forwards
        
        let borderWidthAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        borderWidthAnimation.fromValue = avatarImageView.layer.borderWidth
        borderWidthAnimation.toValue = 0
        borderWidthAnimation.duration = duration
        borderWidthAnimation.isRemovedOnCompletion = false
        borderWidthAnimation.fillMode = .forwards
        
        let alphaAnimation = CABasicAnimation()
        alphaAnimation.keyPath = "opacity"
        alphaAnimation.fromValue = 0.0
        alphaAnimation.toValue = 0.5
        alphaAnimation.duration = duration
        alphaAnimation.isRemovedOnCompletion = false
        alphaAnimation.fillMode = .forwards
        
        whiteView.layer.add(alphaAnimation, forKey: "timeViewFadeIn")
        avatarImageView.layer.add(cornerRadiusAnimation, forKey: "cornerRadius")
        avatarImageView.layer.add(borderWidthAnimation, forKey: "borderWidth")
        avatarImageView.layer.add(growthAnimation, forKey: nil)
        avatarImageView.layer.add(avatarAnimationPosition, forKey: #keyPath(CALayer.position))
        
        CATransaction.commit()
        
        let xMarkTapped = UITapGestureRecognizer(target: self, action: #selector(defaultPositions))
        xMarkTapped.numberOfTapsRequired = 1
        xMarkTapped.numberOfTouchesRequired = 1
        xMark.addGestureRecognizer(xMarkTapped)
        
        xMark.isUserInteractionEnabled = true
        
        UIView.animate(
            withDuration: 0.3,
            delay: duration,
            options: .curveLinear
        ) { [self] in
            xMark.alpha = 1
        }
    }
    
    @objc
    private func defaultPositions() {
        xMark.layer.removeAllAnimations()
        whiteView.layer.removeAllAnimations()
        avatarImageView.layer.removeAllAnimations()
        xMark.alpha = 0
        avatarImageView.isUserInteractionEnabled = true
        xMark.isUserInteractionEnabled = false
    }
    
    @objc
    private func edited() {
        statusLabel.text = status
        self.endEditing(true)
    }
    
    private func setupView() {
        statusLabel.text = status
        #if DEBUG
        backgroundColor = .white
        #else
        backgroundColor = .systemGray6
        #endif
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.launchAnimationExample))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        
        self.avatarImageView.isUserInteractionEnabled = true
        self.avatarImageView.addGestureRecognizer(tapGesture)
    }

    private func addSubviews() {
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(statusTextField)
        addSubview(whiteView)
        addSubview(avatarImageView)
        addSubview(xMark)
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
            
            whiteView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            whiteView.topAnchor.constraint(equalTo: self.topAnchor),
            whiteView.heightAnchor.constraint(equalToConstant: 2000),
            
            xMark.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            xMark.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            xMark.heightAnchor.constraint(equalToConstant: 32),
            xMark.widthAnchor.constraint(equalTo: xMark.heightAnchor),
            
            self.bottomAnchor.constraint(equalTo: setStatusButton.bottomAnchor, constant: 16.0)
        ])
    }
}


extension ProfileHederView: CAAnimationDelegate {

    func animationDidStart(
        _ anim: CAAnimation
    ) {
        print("Did start CAAnimation example")
    }
    
    func animationDidStop(
        _ animation: CAAnimation,
        finished flag: Bool
    ) {
        print("Did finish CAAnimation example")
    }
}
