//
//  PokemonListViewController.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import UIKit

class PokemonListViewController: BaseViewController<PokemonListViewModel> {

    private var lottieView: LottieView!
    private var mainComponent: ItemListView!
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        
        addMainComponent()
        addLottieView()
        fetchPokemons()
        listenLoadingState()
    }
    
    private func addMainComponent() {
        mainComponent = ItemListView()
        mainComponent.translatesAutoresizingMaskIntoConstraints = false
        
        mainComponent.delegate = viewModel
        viewModel.delegate = self
        
        view.addSubview(mainComponent)
        
        NSLayoutConstraint.activate([
        
            mainComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainComponent.topAnchor.constraint(equalTo: view.topAnchor),
            mainComponent.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        self.mainComponent.reloadTableView()
    }
    
    private func addLottieView() {
        lottieView = LottieView(frame: .zero, jsonName: "loading")
        lottieView = lottieView.buildLottieView()
        
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottieView)
        
        NSLayoutConstraint.activate([
        
            lottieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lottieView.widthAnchor.constraint(equalToConstant: 240),
            lottieView.heightAnchor.constraint(equalToConstant: 240),
            
        ])
    }
    
    private func listenLoadingState() {
        viewModel.loadingStatus.observe { [weak self] state in
            guard let self = self else { return }
            if state == .loading {
                DispatchQueue.main.async {
                    self.view.alpha = 0.75
                    self.lottieView.play()
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.view.alpha = 1
                    self.lottieView.stop()
                }
                self.mainComponent.reloadTableView()
            }
        }
    }
    
    func fetchPokemons() {
        viewModel.fetchPokemons { [weak self] pokemon in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.mainComponent.reloadTableView()
                self.title = "\(self.viewModel.pokemons.count) pokemon in \(self.viewModel.totalCount)"
            }
        }
    }
}

extension PokemonListViewController: PokemonListViewModelOutputDelegate {
    func navigateToPokemonDetail(with selectedPokemon: Pokemon) {
        let spriteManager = PokemonSpritesManager()
        let pokemonDetailViewModel = PokemonDetailViewModel(selectedPokemon: selectedPokemon, spriteManager: spriteManager)
        let pokemonDetailVC = PokemonDetailViewController(viewModel: pokemonDetailViewModel)
        pokemonDetailVC.title = selectedPokemon.name?.capitalizingFirstLetter() ?? ""
        self.navigationController?.pushViewController(pokemonDetailVC, animated: true)
    }
    
    func hasMoreLoaded() {
        DispatchQueue.main.async {
            self.mainComponent.reloadTableView()
            self.title = "\(self.viewModel.pokemons.count) pokemon in \(self.viewModel.totalCount)"
        }
    }
}
