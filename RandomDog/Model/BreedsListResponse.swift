//
//  BreedsListResponse.swift
//  RandomDog
//
//  Created by Nathalie Cesarino on 01/03/22.
//

import Foundation

// 3
struct BreedsListResponse: Codable {
    let status: String
    let message: [String:[String]]
}
