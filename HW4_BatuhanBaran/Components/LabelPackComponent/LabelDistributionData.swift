//
//  LabelDistributionData.swift
//  Week_3
//
//  Created by Erkut Bas on 9.10.2021.
//

import UIKit

class LabelDistributionData {
    
    private(set) var lineBreakMode: NSLineBreakMode = .byWordWrapping
    private(set) var numberOfLines: Int = 0
    private(set) var contentMode: UIView.ContentMode = .center
    private(set) var textAlignment: NSTextAlignment = .center
    
    func setLineBreakMode(by value: NSLineBreakMode) -> Self {
        lineBreakMode = value
        return self
    }
    
    func setNumberOfLines(by value: Int) -> Self {
        numberOfLines = value
        return self
    }
    
    func setContentMode(by value: UIView.ContentMode) -> Self {
        contentMode = value
        return self
    }
    
    func setTextAlignment(by value: NSTextAlignment) -> Self {
        textAlignment = value
        return self
    }
    
}
