//
//  DetailData.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/17/22.
//

import Foundation

struct DetailData: Codable {
    let address: DetailAddress
    let attributes: Attributes
    let flatDescription: String
    let id: Int
    let photo: String
    let projectName: String
    let propertyDetails: [PropertyDetail]

    enum CodingKeys: String, CodingKey {
        case address, attributes
        case flatDescription = "description"
        case id, photo
        case projectName = "project_name"
        case propertyDetails = "property_details"
    }
}

struct DetailAddress: Codable {
    let mapCoordinates: MapCoordinates
    let subtitle, title: String

    enum CodingKeys: String, CodingKey {
        case mapCoordinates = "map_coordinates"
        case subtitle, title
    }
}

struct MapCoordinates: Codable {
    let lat, lng: Double
}


// MARK: - PropertyDetail
struct PropertyDetail: Codable {
    let label, text: String
}

