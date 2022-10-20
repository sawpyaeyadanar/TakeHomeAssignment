//
//  Error+Ext.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/13/22.
//

import Foundation
public struct APPError: Codable {
    public let result: String?
    public let errortype: String?
    public let extrainfo: String?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case errortype = "error-type"
        case extrainfo = "extra-info"
    }
}

enum Result<T> {
    case success(T)
    case failure(APPError)
}
