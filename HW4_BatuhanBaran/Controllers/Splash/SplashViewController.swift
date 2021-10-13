//
//  SplashViewController.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 13.10.2021.
//

import UIKit

class SplashViewController: UIViewController {

    private var lottieView: LottieView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lottieView = LottieView()
        lottieView.delegate = self
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lottieView)
        
        NSLayoutConstraint.activate([
        
            lottieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lottieView.widthAnchor.constraint(equalToConstant: 240),
            lottieView.heightAnchor.constraint(equalToConstant: 240),
            
        ])
    }
}

extension SplashViewController: LottieViewOutputDelegate {
    func navigateToPokemonList() {
        var pokemonListVC = BaseBuilder<PokemonListViewController>().build(with: .fullScreen)
        let manager = PokemonListManager()
        let spriteManager = PokemonSpritesManager()
        pokemonListVC = PokemonListViewController(viewModel: PokemonListViewModel(manager: manager, spriteManager: spriteManager))
        let navigationViewController = UINavigationController(rootViewController: pokemonListVC)
        navigationViewController.modalPresentationStyle = .fullScreen
        self.present(navigationViewController, animated: false)
    }
}
