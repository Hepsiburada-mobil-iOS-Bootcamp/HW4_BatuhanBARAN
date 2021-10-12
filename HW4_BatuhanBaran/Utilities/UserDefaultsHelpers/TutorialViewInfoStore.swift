//
//  TutorialViewInfoStore.swift
//  Week_3
//
//  Created by Erkut Bas on 9.10.2021.
//

import Foundation

struct TutorialViewInfoStore {
    
    @UserDefaultsWrapperHelper(key: "hasTutorialSeen", value: false)
    static var hasTutorialSeen: Bool?
    
}
