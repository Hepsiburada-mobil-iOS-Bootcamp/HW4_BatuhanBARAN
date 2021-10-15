//
//  PokemonListViewController.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 12.10.2021.
//

import UIKit

class PokemonListViewController: BaseViewController<PokemonListViewModel> {

    private var mainComponent: ItemListView!
    
    override func prepareViewControllerConfigurations() {
        super.prepareViewControllerConfigurations()
        
        addMainComponent()
        fetchPokemons()
        subscribeViewModelProperties()
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
    
    private func subscribeViewModelProperties() {
        viewModel.loadingStatus.observe { [weak self] loadingState in
            guard let self = self else { return }
            if loadingState == .loading {
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
        
        viewModel.currentPokemonCount.observe { [weak self] count in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.title = "\(count) pokemons in \(self.viewModel.totalPokemonCount)"
            }
        }
    }
    
    func fetchPokemons() {
        viewModel.fetchPokemons { [weak self] pokemon in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.title = "\(pokemon.count) pokemons in \(self.viewModel.totalPokemonCount)"
                self.mainComponent.reloadTableView()
            }
        }
    }
}

extension PokemonListViewController: PokemonListViewModelOutputDelegate {
    func navigateToPokemonDetail(with selectedPokemon: Pokemon) {
        let spriteManager = PokemonSpritesManager()
        let pokemonDetailViewModel = PokemonDetailViewModel(selectedPokemon: selectedPokemon, spriteManager: spriteManager)
        let pokemonDetailVC = PokemonDetailViewController(viewModel: pokemonDetailViewModel, lottieName: "loading")
        pokemonDetailVC.title = selectedPokemon.name?.capitalizingFirstLetter() ?? ""
        self.navigationController?.pushViewController(pokemonDetailVC, animated: true)
    }
    
    func hasMoreLoaded() {
        DispatchQueue.main.async {
            self.mainComponent.reloadTableView()
            
        }
    }
}
