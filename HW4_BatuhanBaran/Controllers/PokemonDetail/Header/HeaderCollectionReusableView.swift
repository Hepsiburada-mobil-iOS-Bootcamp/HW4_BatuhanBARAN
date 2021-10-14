//
//  HeaderCollectionReusableView.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 14.10.2021.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    static var identifier: String {
        return String(describing: self)
    }
    
    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [idLabel, weightLabel, heightLabel])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.distribution = .fill
        temp.axis = .vertical
        temp.spacing = 10
        temp.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        temp.isLayoutMarginsRelativeArrangement = true
        return temp
    }()
    
    private lazy var idLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.textAlignment = .left
        temp.font = FontManager.bold(18).value
        temp.layer.borderWidth = 0.5
        temp.layer.borderColor = UIColor.lightGray.cgColor
        temp.layer.cornerRadius = 8
        return temp
    }()
    
    private lazy var weightLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.textAlignment = .left
        temp.font = FontManager.bold(18).value
        temp.layer.borderWidth = 0.5
        temp.layer.borderColor = UIColor.lightGray.cgColor
        temp.layer.cornerRadius = 8
        return temp
    }()
    
    private lazy var heightLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.textAlignment = .left
        temp.font = FontManager.bold(18).value
        temp.layer.borderWidth = 0.5
        temp.layer.borderColor = UIColor.lightGray.cgColor
        temp.layer.cornerRadius = 8
        return temp
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func prepareReuseableView(with sprites: Sprites?) {
        guard let sprites = sprites else {
            return
        }
        
        addSubview(mainStackView)
        
        self.idLabel.text = " Id: " + String(sprites.id ?? 0)
        self.weightLabel.text = " Weight: " + String(sprites.weight ?? 0)
        self.heightLabel.text = " Height: " + String(sprites.height ?? 0)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            idLabel.heightAnchor.constraint(equalToConstant: 50),
            weightLabel.heightAnchor.constraint(equalToConstant: 50),
            heightLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
