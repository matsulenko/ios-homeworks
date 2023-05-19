import UIKit

final class PhotosTableViewCell: UITableViewHeaderFooterView {
    
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    static let id = "PhotosTableViewCell"
    
    // Можно поменять количество фото на экране профиля, отступы скорректируются
    private var numberOfPhotos = 4
    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Photos"
        
        return label
    }()
        
    private lazy var arrow: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.tintColor = .black
        
        return imageView
    }()
        
    private lazy var photosTableImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        
        return imageView
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
        
    override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
        
        addGestureRecognizer(tapGestureRecognizer)
        
        addSubviews()
        setupConstraints()
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(title)
        contentView.addSubview(arrow)
        contentView.addSubview(separator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            
            arrow.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            arrow.heightAnchor.constraint(equalTo: title.heightAnchor),
            
            separator.heightAnchor.constraint(equalToConstant: 12),
            separator.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }

    private func setupContent() {
        
        contentView.backgroundColor = .white
        
        if numberOfPhotos > 0 {
            for i in 1...numberOfPhotos {
                let photo = UIImageView(frame: .zero)
                photo.translatesAutoresizingMaskIntoConstraints = false
                photo.contentMode = .scaleAspectFill
                photo.layer.masksToBounds = true
                photo.layer.cornerRadius = 6
                let imageName = "cats" + String(i)
                photo.image = UIImage(named: imageName)
                
                contentView.addSubview(photo)
                
                if i == 1 {
                    NSLayoutConstraint.activate([
                        photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
                        contentView.bottomAnchor.constraint(equalTo: photo.bottomAnchor, constant: 24.0),
                        
                    ])
                } else {
                    let previousPhoto = contentView.subviews.dropLast().last
                    
                    NSLayoutConstraint.activate([
                        photo.leadingAnchor.constraint(equalTo: previousPhoto!.trailingAnchor, constant: 8.0),
                    ])
                }
                
                if i == numberOfPhotos {
                    NSLayoutConstraint.activate([
                        photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
                    ])
                }
                
                let constantWidthMinus = CGFloat(((-8*(2+numberOfPhotos))/numberOfPhotos))
                
                NSLayoutConstraint.activate([
                    photo.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12.0),
                    photo.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/CGFloat(numberOfPhotos), constant: constantWidthMinus),
                    photo.heightAnchor.constraint(equalTo: photo.widthAnchor)
                ])
                
            }
        }
    }
}
