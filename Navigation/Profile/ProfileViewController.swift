import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    fileprivate let data = posts
    
    var keyboardIsActive = false
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        addSubviews()
        setupConstraints()
        setupTable()
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
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        if keyboardIsActive == false {
            tableView.contentInset.bottom += keyboardHeight ?? 0.0
            keyboardIsActive = true
        }
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        tableView.contentInset.bottom = 0.0
        keyboardIsActive = false
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupTable() {
        var userService: UserService
        
        #if DEBUG
        userService = TestUserService()
        #else
        userService = CurrentUserService()
        #endif
        
        let user = userService.user        
        let headerView = ProfileHederView()
        headerView.fullNameLabel.text = user.fullName
        headerView.avatarImageView.image = user.avatar
        headerView.statusLabel.text = user.status
        tableView.setAndLayoutTableHeaderView(headerView)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        tableView.register(PhotosTableViewCell.self, forHeaderFooterViewReuseIdentifier: PhotosTableViewCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
    }
    
    private func setupView() {
        #if DEBUG
        view.backgroundColor = .white
        #else
        view.backgroundColor = .systemGray6
        #endif
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
        ])
    }
    
    @objc
    func openPhotos() {
        let photosViewController = PhotosViewController()

        navigationController?.pushViewController(photosViewController, animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
            let post = data[indexPath.row]
            cell.configure(with: post)
            return cell
        
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {

        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: PhotosTableViewCell.id
        ) as? PhotosTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        headerView.tapGestureRecognizer.addTarget(self, action: #selector(self.openPhotos))

        return headerView
    }
        
}

extension UITableView {
    func setAndLayoutTableHeaderView(_ header: UIView) {
        self.tableHeaderView = header
        self.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size =  header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.tableHeaderView = header
    }
}


