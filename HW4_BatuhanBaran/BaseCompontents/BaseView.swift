//
//  BaseView.swift
//  PermissionProject
//
//  Created by Erkut Bas on 25.09.2021.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addMajorViewComponents()
        setupViewConfigurations()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addMajorViewComponents()
        setupViewConfigurations()
    }
    
    func addMajorViewComponents() {
        
    }
    func setupViewConfigurations() { }
    
}
