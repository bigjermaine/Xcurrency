//
//  SymbolModel.swift
//  Xcurrency
//
//  Created by MacBook AIR on 17/07/2023.
//

import Foundation




struct CurrencySymbolsResponse: Codable {
    let success: Bool
    let symbols: [Symbols]
}


struct Symbols:Codable {
    let symbols: [String: String]
}
