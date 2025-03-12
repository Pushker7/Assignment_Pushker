//
//  PostTableViewCell.swift
//  Assignment_Pushker
//
//  Created by Pushker Pandey on 12/03/25.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class PostTableViewCell: UITableViewCell {
    static let identifier = "PostTableViewCell"

    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray // Placeholder background
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(favoriteButton)

        NSLayoutConstraint.activate([
            // Thumbnail Image
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            postImageView.widthAnchor.constraint(equalToConstant: 50),
            postImageView.heightAnchor.constraint(equalToConstant: 50),
            
            // Title Label
            titleLabel.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            // Body Label
            bodyLabel.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 12),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            // Favorite Button
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favoriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configure(with post: Post, isFavorite: Bool) {
        titleLabel.text = post.title
        bodyLabel.text = post.body

        // Load image using a placeholder (If API has images, replace URL)
        let placeholderImage = UIImage(systemName: "photo") // Fallback image
        if let url = URL(string: "https://via.placeholder.com/300x250/ffa500/FFF?text=mostafa+amine") { // Replace with actual image URL
            postImageView.af.setImage(withURL: url, placeholderImage: placeholderImage)
        }

        // Favorite Button UI
        favoriteButton.setImage(
            UIImage(systemName: isFavorite ? "heart.fill" : "heart"),
            for: .normal
        )
        favoriteButton.tintColor = isFavorite ? .red : .gray
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        postImageView.image = nil // Reset image to avoid flickering
    }
}
