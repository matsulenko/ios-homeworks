import UIKit
import SnapKit

class ProfileTableHederView: UIView {
    
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
    
    private func done(_ sender: TextFieldWithPadding) {
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
    private func buttonPressed() {
        statusLabel.text = status
        self.endEditing(true)
    }
    
    private func setupView() {
        fullNameLabel.text = name
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
        fullNameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(27)
        }
        
        statusLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.bottom.equalTo(fullNameLabel.snp.bottom).offset(30)
        }
        
        setStatusButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.top.equalTo(statusTextField.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        avatarImageView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(100)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        statusTextField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.top.equalTo(statusLabel.snp.bottom).offset(16)
        }
        
        whiteView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.top.equalTo(self.snp.top)
            make.height.equalTo(2000)
        }
        
        xMark.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-24)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
            make.height.width.equalTo(32)
        }
        
        self.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(setStatusButton.snp.bottom).offset(16)
        }
    }
}


extension ProfileTableHederView: CAAnimationDelegate {

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
