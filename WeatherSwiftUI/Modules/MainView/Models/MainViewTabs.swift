//
//  MainViewTabs.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 05.04.2026.
//

import Foundation
import RswiftResources

enum MainViewTabs: Hashable {
    case current
    case list
    
    var image: String {
        switch self {
        case .current: "location.fill"
        case .list: "list.bullet"
        }
    }
    
    var localizedTitle: String {
        switch self {
        case .current: R.string.localizable.mainViewCurrentTabTitle()
        case .list: R.string.localizable.mainViewListTabTitle()
        }
    }
}
