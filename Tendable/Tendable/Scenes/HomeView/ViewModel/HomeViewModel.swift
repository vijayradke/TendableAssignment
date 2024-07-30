//
//  HomeViewModel.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

class HomeViewModel: ObservableObject {
 
    var displayName: String {
        Preference.userEmail
    }
}
