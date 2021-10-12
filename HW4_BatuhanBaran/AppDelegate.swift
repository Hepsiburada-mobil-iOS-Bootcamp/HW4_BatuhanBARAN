//
//  AppDelegate.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 11.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        var pokemonListVC = BaseBuilder<PokemonListViewController>().build(with: .fullScreen)
        let manager = PokemonListManager()
        pokemonListVC = PokemonListViewController(viewModel: PokemonListViewModel(manager: manager))
        let navigationViewController = UINavigationController(rootViewController: pokemonListVC)
        
        window?.rootViewController = navigationViewController
        
        return true
    }
}

