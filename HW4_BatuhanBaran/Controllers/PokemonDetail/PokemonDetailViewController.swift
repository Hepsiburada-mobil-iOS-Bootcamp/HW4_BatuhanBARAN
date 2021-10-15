//
//  PokemonDetailViewController.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import UIKit

class PokemonDetailViewController: BaseViewController<PokemonDetailViewModel> {
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    
        collectionViewLayout.minimumInteritemSpacing = 30
        collectionViewLayout.minimumLineSpacing = 30
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(PokemonSpritesCollectionViewCell.self, forCellWithReuseIdentifier: PokemonSpritesCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)

        return collectionView
    }()
    
    var spriteUrls = [String]()
    var sprites: Sprites?
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        fetchSprites()
        subscribeLoadingState()
    }
    
    private func fetchSprites() {
        viewModel.fetchSprites { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self else { return }
                guard let data = data else { return }
                self.sprites = data
                
                self.spriteUrls.append(data.sprites?.back_default ?? "")
                self.spriteUrls.append(data.sprites?.back_shiny ?? "")
                self.spriteUrls.append(data.sprites?.back_female ?? "")
                self.spriteUrls.append(data.sprites?.back_shiny_female ?? "")
                self.spriteUrls.append(data.sprites?.front_default ?? "")
                self.spriteUrls.append(data.sprites?.front_shiny ?? "")
                self.spriteUrls.append(data.sprites?.front_shiny_female ?? "")
                self.spriteUrls = self.spriteUrls.filter({ $0 != ""})
                
                self.configureCollectionView()
            }
        }
    }
    
    private func subscribeLoadingState() {
        viewModel.loadingStatus.observe { [weak self] loadingState in
            guard let self = self else { return }
            if loadingState == .loading {
                DispatchQueue.main.async {
                    // todo ask teacher
                    self.collectionView.isHidden = true
                    self.lottieView.play()
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.lottieView.stop()
                    self.collectionView.isHidden = false
                }
            }
        }
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12)
        ])
        
        self.collectionView.reloadData()
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
        return UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView() }
        header.prepareReuseableView(with: sprites)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 210)
    }
}
