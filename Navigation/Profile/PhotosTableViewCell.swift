import UIKit

final class PhotosTableViewCell: UITableViewHeaderFooterView {
    
    
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    static let id = "PhotosTableViewCell"
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
    }
    
    fileprivate let numberOfPhotos: Int = 4
    
    fileprivate var photos: [String] = []
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier
        )
        
        return collectionView
    }()
    
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
        #if DEBUG
        view.backgroundColor = .white
        #else
        view.backgroundColor = .systemGray6
        #endif
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
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        let constantWidthMinus = CGFloat(((-8*(2+numberOfPhotos))/numberOfPhotos))
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0),
            
            arrow.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0),
            arrow.heightAnchor.constraint(equalTo: title.heightAnchor),
            
            separator.heightAnchor.constraint(equalToConstant: 12),
            separator.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: arrow.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12.0),
            collectionView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/CGFloat(numberOfPhotos), constant: constantWidthMinus),

            contentView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24.0),
        ])
    }

    private func setupContent() {
        
        contentView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addPhotos()
        
    }
    
    private func addPhotos() {
        for i in 1...numberOfPhotos {
            let imageName = "cats" + String(i)
            photos.append(imageName)
        }
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        photos.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.identifier,
            for: indexPath) as! PhotosCollectionViewCell
        
        let photo = photos[indexPath.row]
        cell.setupMain(with: photo)
        
        return cell
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(
        for width: CGFloat,
        spacing: CGFloat
    ) -> CGFloat {
        let itemsInRow: CGFloat = 4
        
        let totalSpacing: CGFloat = CGFloat((8*(2+numberOfPhotos)))
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = itemWidth(
            for: contentView.frame.width,
            spacing: LayoutConstant.spacing
        )
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        LayoutConstant.spacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        LayoutConstant.spacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        cell.contentView.backgroundColor = .white
    }
}
