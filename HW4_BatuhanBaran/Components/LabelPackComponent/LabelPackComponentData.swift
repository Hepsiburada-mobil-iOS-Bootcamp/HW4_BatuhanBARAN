//
//  LabelPackComponentData.swift
//  PermissionProject
//
//  Created by Erkut Bas on 26.09.2021.
//

import UIKit

class LabelPackComponentData {
    
    private(set) var title: String
    private(set) var subTitle: String
    private(set) var stackViewAlignment: UIStackView.Alignment = .center
    private(set) var spacing: CGFloat = 10
    private(set) var titleLabelDistributionData: LabelDistributionData = LabelDistributionData()
    private(set) var subTitleLabelDistributionData: LabelDistributionData = LabelDistributionData()
    
    init(title: String = "",
         subTitle: String = "") {
        self.title = title
        self.subTitle = subTitle
    }
    
    func setTitleLabelDistributionData(by value: LabelDistributionData) -> Self {
        titleLabelDistributionData = value
        return self
    }
    
    func setSubTitleLabelDistributionData(by value: LabelDistributionData) -> Self {
        subTitleLabelDistributionData = value
        return self
    }
    
    func setStackViewAlignment(by value: UIStackView.Alignment) -> Self {
        stackViewAlignment = value
        return self
    }
    
    func setSpacing(by value: CGFloat) -> Self {
        spacing = value
        return self
    }
    
}
