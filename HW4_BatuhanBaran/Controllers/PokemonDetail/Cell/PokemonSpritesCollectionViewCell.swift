//
//  PokemonSpritesCollectionViewCell.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 14.10.2021.
//

import UIKit
import Kingfisher

class PokemonSpritesCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private lazy var shadowContainer: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.layer.shadowColor = UIColor.black.cgColor
        temp.layer.shadowOffset = CGSize(width: 0, height: 2)
        temp.layer.shadowRadius = 4
        temp.layer.shadowOpacity = 0.4
        temp.layer.cornerRadius = 6
        return temp
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(pokemonImageView)
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.75
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor

        contentView.layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        NSLayoutConstraint.activate([
            
            pokemonImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pokemonImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: topAnchor),
            pokemonImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    func configure(with url: String) {
        guard let url = URL(string: url) else { return }
        self.pokemonImageView.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
