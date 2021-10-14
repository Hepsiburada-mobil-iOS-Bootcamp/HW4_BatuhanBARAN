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
        
        self.title = "\(viewModel.pokemons.count) pokemon in \(viewModel.totalCount)"
        addmainComponent()
        fetchPokemons()
    }
    
    private func addmainComponent() {
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
    }
    
    func fetchPokemons() {
        viewModel.fetchPokemons()
        self.mainComponent.reloadTableView()
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
