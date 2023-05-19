import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private lazy var photosImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupLayouts()
    }
    
    private func setupView() {
        contentView.addSubview(photosImageView)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            photosImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photosImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photosImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photosImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            photosImageView.heightAnchor.constraint(equalTo: photosImageView.widthAnchor)
        ])
    }
    
    func setup(
        with photos: String
    ) {
        photosImageView.image = UIImage(named: photos)
    }
}
