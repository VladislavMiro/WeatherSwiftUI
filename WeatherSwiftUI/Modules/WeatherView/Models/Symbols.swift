//
//  Symbols.swift
//  WeatherSwiftUI
//
//  Created by Vladislav Miroshnichenko on 09.04.2026.
//

import Foundation
import RswiftResources

enum Symbols: CustomStringConvertible {
    case celciusSymbol
    case kmPerHour
    case km
    case precent
    case hPa
    case mBa
    case mm
    
    var description: String {
        switch self {
        case .celciusSymbol:
            R.string.localizable.symbolsCelciusSymbol()
        case .kmPerHour:
            R.string.localizable.symbolsKmPerHour()
        case .km:
            R.string.localizable.symbolsKm()
        case .precent:
            R.string.localizable.symbolsPrecent()
        case .hPa:
            R.string.localizable.symbolsHPa()
        case .mBa:
            R.string.localizable.symbolsMBa()
        case .mm:
            R.string.localizable.symbolsMm()
        }
    }
}
