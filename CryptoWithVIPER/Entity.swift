//
//  Entity.swift
//  CryptoWithVIPER
//
//  Created by Hasan Kaya on 18.08.2022.
//

import Foundation

// Struct
struct Crypto: Codable {
    let id, currency, symbol, name: String
    let status, price, rank: String
}

