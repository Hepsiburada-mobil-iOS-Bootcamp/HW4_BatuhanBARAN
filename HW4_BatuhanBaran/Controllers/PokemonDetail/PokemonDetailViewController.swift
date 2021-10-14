//
//  PokemonDetailViewController.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import UIKit

class PokemonDetailViewController: BaseViewController<PokemonDetailViewModel> {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        //scrollView.backgroundColor = .red
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        //contentView.backgroundColor = .green
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [idLabel, weightLabel, heightLabel])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.distribution = .fillEqually
        temp.axis = .vertical
        temp.spacing = 10
        return temp
    }()
    
    private lazy var idLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.textAlignment = .left
        temp.font = FontManager.bold(18).value
        return temp
    }()
    
    private lazy var weightLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.textAlignment = .left
        temp.font = FontManager.bold(18).value
        return temp
    }()
    
    private lazy var heightLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.textColor = .black
        temp.textAlignment = .left
        temp.font = FontManager.bold(18).value
        return temp
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewLayout.minimumInteritemSpacing = 30
        collectionViewLayout.minimumLineSpacing = 30
        collectionView.register(PokemonSpritesCollectionViewCell.self, forCellWithReuseIdentifier: PokemonSpritesCollectionViewCell.identifier)
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var spriteUrls = [String]()
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        
        viewModel.fetchSprites { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self else { return }
                guard let data = data else { return }
                self.idLabel.text = "Id: " + String(data.id ?? 0)
                self.weightLabel.text = "Weight: " + String(data.weight ?? 0)
                self.heightLabel.text = "Height: " + String(data.height ?? 0)
                
                self.spriteUrls.append(data.sprites?.back_default ?? "")
                self.spriteUrls.append(data.sprites?.back_shiny ?? "")
                self.spriteUrls.append(data.sprites?.back_female ?? "")
                self.spriteUrls.append(data.sprites?.back_shiny_female ?? "")
                self.spriteUrls.append(data.sprites?.front_default ?? "")
                self.spriteUrls.append(data.sprites?.front_shiny ?? "")
                self.spriteUrls.append(data.sprites?.front_shiny_female ?? "")
                self.spriteUrls = self.spriteUrls.filter({ $0 != ""})
                
                self.configureSubviews()
                self.setupConstraints()
            }
        }
    }
    
    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(mainStackView)
        stackView.addArrangedSubview(collectionView)
        
        NSLayoutConstraint.activate([
            idLabel.heightAnchor.constraint(equalToConstant: 50),
            weightLabel.heightAnchor.constraint(equalToConstant: 50),
            heightLabel.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.heightAnchor.constraint(equalToConstant: CGFloat(spriteUrls.count * 100)),
        ])
        
        self.collectionView.reloadData()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        
        for view in stackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                // todo asking
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
    }
}

extension PokemonDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonSpritesCollectionViewCell.identifier, for: indexPath) as? PokemonSpritesCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: self.spriteUrls[indexPath.row])
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.spriteUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.5, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}
