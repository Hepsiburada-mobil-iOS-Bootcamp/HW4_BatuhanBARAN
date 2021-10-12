//
//  PageViewImages.swift
//  Week_3
//
//  Created by Erkut Bas on 2.10.2021.
//

import UIKit

enum PageViewImages: String, GenericValueProtocol {

    typealias Value = UIImage
    
    var value: UIImage {
        return UIImage(imageLiteralResourceName: rawValue)
    }
    
    case page1 = "page1"
    case page2 = "page2"
    case page3 = "page3"
    
}
