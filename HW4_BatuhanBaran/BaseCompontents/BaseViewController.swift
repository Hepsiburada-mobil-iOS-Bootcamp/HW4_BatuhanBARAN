//
//  BaseViewController.swift
//  PermissionProject
//
//  Created by Erkut Bas on 26.09.2021.
//

import UIKit

class BaseViewController<V>: UIViewController {
    
    var viewModel: V!
    var lottieName: String = ""
    var lottieView: LottieView!
    
    convenience init(viewModel: V, lottieName: String) {
        self.init()
        self.viewModel = viewModel
        self.lottieName = lottieName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewControllerConfigurations()
        addLottieView()
    }
    
    func prepareViewControllerConfigurations() {
        view.backgroundColor = .white
    }
    
    private func addLottieView() {
        lottieView = LottieView(frame: .zero, jsonName: lottieName)
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
    
}
