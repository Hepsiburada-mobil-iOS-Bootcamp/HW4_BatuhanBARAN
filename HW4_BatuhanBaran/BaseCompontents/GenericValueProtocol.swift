//
//  GenericValueProtocol.swift
//  PermissionProject
//
//  Created by Erkut Bas on 25.09.2021.
//

import Foundation

protocol GenericValueProtocol {
    associatedtype Value
    var value: Value { get }
}
