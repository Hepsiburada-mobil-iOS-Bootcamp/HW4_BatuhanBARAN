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
        
        view.backgroundColor = UIColor(red: 227 / 255, green: 52 / 255, blue: 47 / 255, alpha: 1)
        addLottieView()
    }
    
    private func addLottieView() {
        lottieView = LottieView(frame: .zero, jsonName: "pokemon")
        lottieView = lottieView.buildLottieView()
        lottieView.delegate = self
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lottieView)
        
        NSLayoutConstraint.activate([
        
            lottieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lottieView.widthAnchor.constraint(equalToConstant: 240),
            lottieView.heightAnchor.constraint(equalToConstant: 240),
            
        ])
        
        lottieView.play()
    }
}

extension SplashViewController: LottieViewOutputDelegate {
    func navigateToPokemonList() {
        var pokemonListVC = BaseBuilder<PokemonListViewController>().build(with: .fullScreen)
        let manager = PokemonListManager()
        pokemonListVC = PokemonListViewController(viewModel: PokemonListViewModel(manager: manager))
        let navigationViewController = UINavigationController(rootViewController: pokemonListVC)
        navigationViewController.modalPresentationStyle = .fullScreen
        self.present(navigationViewController, animated: false)
    }
}
