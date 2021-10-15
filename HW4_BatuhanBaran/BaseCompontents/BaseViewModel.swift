//
//  BaseViewModel.swift
//  HW4_BatuhanBaran
//
//  Created by Batuhan BARAN on 15.10.2021.
//

import Foundation

protocol BaseViewModel {
    var loadingState: Observable<LoadingState> {get set}
}
