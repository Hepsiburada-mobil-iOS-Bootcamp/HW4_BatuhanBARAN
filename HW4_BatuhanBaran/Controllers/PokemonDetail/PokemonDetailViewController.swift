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
        temp.alignment = .center
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
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        
        configureSubviews()
        setupConstraints()
        
        viewModel.fetchSprites { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.idLabel.text = "Id: " + String(data?.id ?? 0)
                self.weightLabel.text = "Weight: " + String(data?.weight ?? 0)
                self.heightLabel.text = "Height: " + String(data?.height ?? 0)
            }
        }
    }
    
    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            idLabel.heightAnchor.constraint(equalToConstant: 65),
            weightLabel.heightAnchor.constraint(equalToConstant: 65),
            heightLabel.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
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
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
    }
}
