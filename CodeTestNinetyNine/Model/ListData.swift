//
//  ListData.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/13/22.
//

import Foundation

struct ListData: Codable {
    let address: Address
    let attributes: Attributes
    let category, completed_at: String
    let id: Int
    let photo: String
    let project_name: String
    let tenure: Int
}

struct Address: Codable {
    let district, street_name: String
}

struct Attributes: Codable {
    let area_size, bathrooms, bedrooms, price: Int
}
