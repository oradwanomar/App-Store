//
//  FeaturedCollectionViewCell.swift
//  App-Store
//
//  Created by Omar Ahmed on 13/06/2022.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell,SelfConfiguringCell {
    
    static var reuseIdentifier: String = "FeaturedCell"
    let tagLine = UILabel()
    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        tagLine.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 14,weight: .bold))
        tagLine.textColor = .systemBlue
        
        name.font = UIFont.preferredFont(forTextStyle: .title2)
        name.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .title2)
        subtitle.textColor = .secondaryLabel
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [tagLine,name,subtitle,imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        stackView.setCustomSpacing(10, after: subtitle)
    }
    
    func configure(with app: App) {
        tagLine.text = app.tagline.uppercased()
        name.text = app.name
        subtitle.text = app.subheading
        imageView.image = UIImage(named: app.image)
    }
    
    
}
